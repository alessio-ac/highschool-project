#!/usr/bin/python3

import cgi

def writeName(name):
    with open('/var/www/html/cgi-write/list.txt', 'a') as file:
        file.write(name + "\n")

def getNames():
    names = []
    with open('/var/www/html/cgi-write/list.txt', 'r') as file:
        for line in file:
            names.append(line.strip())
    return names

form = cgi.FieldStorage()
name = form.getvalue('name', '')

if name:
    writeName(name)

nameList = ""
names = getNames()
for name in names:
    nameList += f"<li>{name}</li>"

print("Content-type: text/html")
print()

print(f"""
<!DOCTYPE html>
<html>
<head>
    <title>Registro nomi</title>
</head>
<body>
    <h1>Registro nomi</h1>
    <form method="post" action="registro.cgi">
        <label for="name">Inserisci il nome:</label>
        <input type="text" id="name" name="name">
        <input type="submit" value="Save">
    </form>
    <hr>
    <h2>Nomi nel file:</h2>
    <ul>
        {nameList}
    </ul>
</body>
</html>
""")
