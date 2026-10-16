import tkinter as tk
root = tk.Tk()

myset = {'red', 'blue', 'green', 'white'}
def handle_click1(event):
    lab1.config(text=str(myset))

def handle_click2(event):
    myset.clear()
    lab1.config(text='Cleared')

def handle_click3(event):
    myset.add(ent1.get())
    lab1.config(text='Added ' + ent1.get())

def handle_click4(event):
    if len(myset):
        lab1.config(text='Popped ' + myset.pop())
    else:
        lab1.config(text='Nothing to pop')

def handle_click5(event):
    if ent1.get() in myset:
        myset.remove(ent1.get())
        lab1.config(text='Removed ' + ent1.get())
    else:
        lab1.config(text= ent1.get() + ' Does not exist')

but1 = tk.Button(text='Display all', width=25, bg='orange')
but1.bind('<Button-1>', handle_click1)
but1.pack()

but2 = tk.Button(text='Clear' , width=25, bg='lightblue')
but2.bind('<Button-1>', handle_click2)
but2.pack()

but3 = tk.Button(text='Add item' , width=25, bg='lightgreen')
but3.bind('<Button-1>', handle_click3)
but3.pack()

but4 = tk.Button(text='Pop item' , width=25, bg='lightyellow')
but4.bind('<Button-1>', handle_click4)
but4.pack()

but5 = tk.Button(text='Remove item' , width=25, bg='lightpink')
but5.bind('<Button-1>', handle_click5)
but5.pack()

ent1 = tk.Entry()
ent1.pack()

lab1 = tk.Label(text='Hello, world!')
lab1.pack()

root.mainloop()