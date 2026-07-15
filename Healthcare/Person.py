# models/person.py
class Person:
    def __init__(self, id, name, age):
        self.id = id
        self.name = name
        self.age = age

    def display_info(self):
        return f"ID: {self.id}, Name: {self.name}, Age: {self.age}"

    def get_details(self):
        return {"id": self.id, "name": self.name, "age": self.age}
