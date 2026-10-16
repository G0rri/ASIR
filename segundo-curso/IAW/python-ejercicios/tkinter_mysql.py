import tkinter as tk
window = tk.Tk()

import mysql.connector
mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password=""
)

def handle_click1(event):
    if ent1.get() == '':
        myquery = 'SELECT * FROM customer'
        mycursor.execute(myquery)
    else:
        myquery = 'SELECT * FROM customer WHERE city = %s'
        mycursor.execute(myquery, (ent1.get(),))
    myresult = mycursor.fetchall()
    mystring = ''
    for x in myresult:
        mystring = mystring + str(x) + '\n'
    lab1.config(text=mystring)

mycursor = mydb.cursor()
mycursor.execute("USE sales")
mycursor.execute("SELECT * FROM customer")
myresult = mycursor.fetchall()
mystring = ''
for x in myresult:
    mystring = mystring + str(x) + '\n'

lab1 = tk.Label(text=mystring)
lab1.pack()
lab2 = tk.Label(text='City:')
lab2.pack()
ent1 = tk.Entry()
ent1.pack()

but1 = tk.Button(text='Go', width=25, bg='orange')
but1.bind('<Button-1>', handle_click1)
but1.pack()

window.mainloop()