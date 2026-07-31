# smart_device.py
from abc import ABC, abstractmethod

class SmartDevice(ABC):
    """Abstract Base Class defining the standard interface for all smart devices."""
    
    @abstractmethod
    def turn_on(self):
        """Turn the device on."""
        pass

    @abstractmethod
    def turn_off(self):
        """Turn the device off."""
        pass
# devices.py
from dataclasses import dataclass
from smart_device import SmartDevice

@dataclass
class Device(SmartDevice):
    """Dataclass representing a generic device."""
    name: str
    device_type: str
    power_watts: int

    def __repr__(self):
        # Custom magic method for representation
        return f"Device(name='{self.name}', type='{self.device_type}', power={self.power_watts}W)"

@dataclass
class SmartLight(Device):
    def turn_on(self):
        return f"[💡] {self.name} (Light) turned ON."

    def turn_off(self):
        return f"[💡] {self.name} (Light) turned OFF."

@dataclass
class SmartLock(Device):
    def turn_on(self):
        return f"[🔒] {self.name} (Lock) is now ENGAGED (Locked)."

    def turn_off(self):
        return f"[🔓] {self.name} (Lock) is now DISENGAGED (Unlocked)."

@dataclass
class SmartThermostat(Device):
    # Dataclass field for the backing variable
    _target_temp: float = 22.0 

    def __post_init__(self):
        # Trigger validation upon initialization
        self.target_temp = self._target_temp

    @property
    def target_temp(self) -> float:
        """Property to get the target temperature."""
        return self._target_temp

    @target_temp.setter
    def target_temp(self, value: float):
        """Property setter that rejects values outside 16-30°C."""
        if 16.0 <= value <= 30.0:
            self._target_temp = value
        else:
            raise ValueError(f"Rejected {value}°C: Target temperature must be between 16°C and 30°C")

    def turn_on(self):
        return f"[🌡️] {self.name} (Thermostat) is actively maintaining {self.target_temp}°C."

    def turn_off(self):
        return f"[🌡️] {self.name} (Thermostat) turned OFF."
# room.py
from devices import Device

class Room:
    """A room that holds a list of devices (Composition)."""
    def __init__(self, name: str):
        self.name = name
        self.devices: list[Device] = []

    def add_device(self, device: Device):
        self.devices.append(device)

    def __len__(self):
        # Magic method returning the device count in the room
        return len(self.devices)
    
    def __repr__(self):
        return f"Room(name='{self.name}', devices={len(self)})"
# smart_home.py
from room import Room

class SmartHome:
    """A smart home that holds a list of rooms (Composition)."""
    def __init__(self, name: str):
        self.name = name
        self.rooms: list[Room] = []

    def add_room(self, room: Room):
        self.rooms.append(room)

    def __getitem__(self, room_name: str):
        # Magic method allowing dictionary-style lookup by room name: home["Living Room"]
        for room in self.rooms:
            if room.name.lower() == room_name.lower():
                return room
        raise KeyError(f"Room '{room_name}' not found in {self.name}.")
# main.py
from devices import SmartLight, SmartLock, SmartThermostat
from room import Room
from smart_home import SmartHome

def main():
    # 1. Initialize SmartHome
    my_home = SmartHome("Skyline Penthouse")

    # 2. Initialize Rooms
    living_room = Room("Living Room")
    bedroom = Room("Master Bedroom")

    # 3. Create Devices
    light1 = SmartLight(name="Main Chandelier", device_type="Smart Bulb", power_watts=60)
    lock1 = SmartLock(name="Front Door Lock", device_type="Deadbolt", power_watts=5)
    
    # Thermostat defaults to 22.0°C
    thermo1 = SmartThermostat(name="Nest Living Room", device_type="HVAC Controller", power_watts=15)

    # 4. Compose Home Structure (Home -> Room -> Devices)
    living_room.add_device(light1)
    living_room.add_device(thermo1)
    bedroom.add_device(lock1)
    
    my_home.add_room(living_room)
    my_home.add_room(bedroom)

    # 5. Test Features & Magic Methods
    print("--- Testing Magic Methods ---")
    print(f"Device __repr__: {light1}")
    print(f"Room __len__: The {living_room.name} has {len(living_room)} devices.")
    
    # Test __getitem__ lookup
    found_room = my_home["Master Bedroom"]
    print(f"SmartHome __getitem__: Found {found_room.name} with {len(found_room)} device(s).")
    
    print("\n--- Testing ABC Implementations ---")
    for room in my_home.rooms:
        for device in room.devices:
            print(device.turn_on())

    print("\n--- Testing Property Validation ---")
    print(f"Current temp: {thermo1.target_temp}°C")
    
    try:
        print("Attempting to set temp to 35°C...")
        thermo1.target_temp = 35.0  # Should fail
    except ValueError as e:
        print(f"Caught Exception: {e}")

    try:
        print("Attempting to set temp to 18°C...")
        thermo1.target_temp = 18.0  # Should succeed
        print(f"Success! New temp is {thermo1.target_temp}°C")
    except ValueError as e:
        print(f"Caught Exception: {e}")

if __name__ == "__main__":
    main()
