# Table of Contents

### [Introduction](#introduction-1)
##### [Learning ReaScript and Lua](#learning-reascript-and-lua-1)
##### [Create and load scripts in Reaper](#create-and-load-scripts-in-reaper-1)
##### [Text editors and IDE's](#about-text-editors-and-ides)
### [Basic Concepts](#basic-concepts-1)
##### [Reaper API and ReaScript](#reaper-api-and-reascript-1)
##### [Learn to use documentation](#documentation)
###### [Variables](#variables-1)
###### [Conditions](#conditions-1)
###### [Tables and Loops](#tables-and-loops-1)
### [Writing a Reaper script from scratch](#writing-a-reaper-script-from-scratch-1)
###### [Pseudocode](#pseudocode-1)

# Introduction

## Learning ReaScript and Lua
This tutorial focuses on understanding some of the foundational programming concepts needed to create practical scripts and workflows in Reaper. With this knowledge you will have a base understanding which you can build on should you want to develop your skills further.

By following along, you'll create an audio item variation script that applies random volume to the selected items, based on user defined boundaries. Should you want to, you'll be able to modify and extend the script to suit your needs.

**The tutorial will cover:**
- Key programming concepts
- How to use pseudocode
- How to approach and use documentation
- How to write scripts in Reaper with ReaScript and the programming language Lua

**Which will give you:**
- The skills to create your own scripts in Reaper
- A foundation to easier explore programming further
- A better general understanding of program logic
- Easier communication with programmers

## Create and load scripts in Reaper
So, first of all we need to know where and how we load user scripts in Reaper.
You might be familiar with the ReaPack extension and have perhaps used that to import actions into Reaper.

Loading a script that is placed locally on your computer is a little different (same goes for creating one).

### Locating the scripts folder
In Reaper, open the "options" context menu. From there locate and open "Show REAPER resource path in explorer/finder...".
This opens up the Reaper ressource folder, where themes, settings, scripts, etc. is located.

Go to "Scripts" and here you will find all your custom scripts (including the ones installed with ReaPack). To keep things tidy let's create a folder called "User" in which we will place our user scripts.

### Creating a script
Back in Reaper open the action list again.
From here press "New action..." and then "New ReaScript...".

Reaper will prompt us for a name and location for the .lua file it will create, so let's call it "test" and place it in the "user" folder we just created.

> Loading a script works similar, the script just needs to be created beforehand. Then you press "Load ReaScript..." and choose it. You can in theory load it from anywhere on your computer, but I recommend this location inside Reaper's ressource folder.

In the moment the script is created Reaper opens it's own "IDE". IDE is just a fancy text editor that among other things highlights parts of the code (which is just plain text) for easier overview. See the section ["about text editors and IDEs"](#about-text-editors-and-ides) for more info.

### Call the script
Before we start to write any actual code we want to make sure everything works, and that the script can indeed be called from the action menu.

Now is a good time to learn the "print to console" function that we can use inside of Reaper's IDE.

We will make it say "Hello World" which is the most conventional way to validate that a script can be called and that it is working.

Let's type:
```lua
reaper.ShowConsoleMsg("Hello World")
```
Saved it with "ctrl/cmd + s" and it will save and immediately run.

ReaScripts console window will popup with the message:

```
Hello World
```

If we close the IDE window we can find the script we just created in the action list.
Find "test.lua" -> select it -> press "Run". As you can see it is called like every other action from the action list.

## About text editors and IDEs
The code editor we open inside of Reaper is the ReaScript IDE.

IDE stands for Integrated Development Environment and is just a very fancy text editor that can run the code you write in it. In theory you can write your entire code inside of Notepad or TextEdit, but the difference is that Notepad or TextExit cannot RUN your code (so you can't check if it's working). An IDE (in contrast to a simple text editor) also have tons of quality of life improvements when you write your code.

Two very useful features that I find worth mentioning is:
- Syntax highlighting → highlights the code in different colors so it is easier to read
- Intellisense which provides code completion (intelligently suggests code while writing) and quick documentation info (provides descriptions and explanations of your code as a popup in the editor).

# Basic Concepts
This section covers some of the core programming concepts and essential development approaches which we need, in order to write actually useful scripts in Reaper.

## Reaper API and ReaScript
What is an API and what purpose does it serve?

#### What is an API?
API stands for **Application Programming Interface**. An API is a collection of things a program allows you to do through code.

In short: an API makes it possible to interact with a program using code.

I think the best way to describe it, is as **a text-based way of telling a program what to do**. For example, instead of clicking a button to trigger an action, you write instructions (in other words *code*) to make it happen.

Let's make an example of the actions we call in Reaper.

Navigate to “**Actions**” → “**Show action list…**” and search for:
*Track: Toggle mute for selected tracks*

If we have a track selected we can call this action by pressing the "**Run**" button. We can also attach the action to a button in one of Reapers toolbars and press that button in order to call the action.

That is the "GUI" version of calling the action.

But let’s say we want to do it in a script instead. Let´s try it out in our test script.

1. Right click the action and select "**Copy selected action command ID**".

2. Inside our test script, after the Hello World line, write the line and replace `<command ID>`with the ID you have copied:
    ```lua
    reaper.Main_OnCommand(<command ID>, 1)
    ```

In my Reaper install that is `6`. So the final line could look like this:
```lua
reaper.Main_OnCommand(6, 1)
```

Now we have effectively done the same thing - muting the track - but through code, inside a script.
The `reaper.Main_OnCommand` function is part of the Reaper API, and we’ve just used it.
The exact way we called it (what we typed) is defined in the ReaScript documentation, which we will cover in the next section.

> Exactly what we type, and how we type it, is what we call the **syntax** of a programming language.

## Documentation
Documentation is our practical handbook and user manual of the language and the API we use. We use it to know what to write and how to write it.

### ReaScript documentation
The code we wrote earlier that printed "Hello World" to the console:
```lua
reaper.ShowConsoleMsg("Hello World")
```
uses the code function `reaper.ShowConsoleMsg()` to write the text we give it. How do we know what functions we can use, and what they are called? In other words, how do we know what to write?

**We use documentation.**

For Reaper, that is the ReaScript documentation.

Searching documentation is key to figuring out how to write something - and fix issues. And since no developer remembers everything, looking things up is more often than not a part of the developer process. I recommend having the documentation open beside your code while you're working.

Let's go to the ReaScript's about page on Reapers website:
https://www.reaper.fm/sdk/reascript/reascript.php

>This page covers the necessary information and resources for getting started using ReaScript.

In the section "ReaScript Documentation" right above, you will find a link to the<br> ReaScript docs:
https://www.reaper.fm/sdk/reascript/reascripthelp.html.<br>
This Documentation is also available inside of Reaper if you navigate to "**Help**" -> "**ReaScript documentation**".

So let's find the API command we used to call native Reaper actions. We simple use the browsers 'find' functionality and search for keywords. In this example our keyword could be "consolemsg". While this works it can be an inconvient way to search so I don't use the official documenation that much.

### Other ways to check for documentation
Big shout to [x-raym](https://www.extremraym.com/en/) who has wrapped the documentation into a much nicer "package" that is more convenient and nice to the eye:
https://www.extremraym.com/cloud/reascript-doc/

While the official documentation is always the most up-to-date, I recommend this one since it is much easier to search through and find what you need.
### Lua documentation
Since Lua is the language we will use to create these scripts, the Lua reference manual is a place to look for answers regarding syntax (where to place the sqaure brackets, how to declare the end of a function, etc.).

I again recommend a unoffical documentation page, because it's easier to navigate:
[LuaDocs unoffical document](https://www.luadocs.com/docs/introduction)

The official documentation can be found here: [The official reference manual](https://www.lua.org/manual/5.4/manual.html) <br>

### Using LLM's?
Using AI can be helpful when you are stuck or trying to understanding, but I would encourage to use it thoughtfully. The real danger is relying on it mindlessly and without critical thought on its output. My advice would be to use it as inspiration on *what to search for*, and ideally as a last resort as well. If you make ChatGPT write every line of your code and it fails at the final part, you're stuck because you most likely don't understand the rest of what was written.

You can use it to help search for documentation, like finding specific functions you need, but I would advice to double check the documentation as well since trusting it blindly is a sure way to run into problems later.

Believe me, I've fallen into that trap many times when I was either in a hurry or just being impatient.

## Variables
### What is a variable
Most of the time a program or script have to store data temporarily in order to function correctly. As an example, if we want a script to set all selected tracks in our Reaper session to a gain level of -16dB, we might want to store this dB value before we start applying it to all the tracks.

In order to do that we use **variables**.

A variable is a container used to store data in. More specifically a variable store a *value* in a programs memory, and by storing it we can use it later in the scripts execution.

We define a variable by giving it a name (the containername) which we can then put the data in (the value).

![variable example](/attachments/variable%20example.png)

### Creating a variable
So let's create a variable and store a number in it:
```lua
variablename = 24
```

We can then call this variable by calling it's name `variablename`.
Lua has a built-in method of printing data in the console. This method (e.g. function) is called `print()`. But since we are in a Reaper environment we can't use it, and have to opt for the `reaper.ShowConsoleMsg()`.

Let's write that function and put our variable name inside of the parenthesis so the function prints the variable value to the console:

```lua
variablename = 24
reaper.ShowConsoleMsg(variablename)
```

Now the ReaScript console should pop up and show:
```lua
24
```

### Variable types
Okay, so we have stored a number inside the variable "variablename". Let's create another variable and store a sentence in it.

Any value that contains a sequence of characters, numbers and/or symbols can be stored in a variable as a **string**. Strings is often used for text. We specify a "string"-value by enclosing it in quotes. That way the program knows it is meant to be a string and it's beginning and end is clearly defined by enclosing it in these quotes.

Let's create a string:
```lua
stringname = "number of tracks: "
```
And print it to the console:
```lua
reaper.ShowConsoleMsg(stringname)
```

Arrange the code so it looks like this:
```lua
variablename = 24
stringname = "number of tracks: "

reaper.ShowConsoleMsg(stringname)
reaper.ShowConsoleMsg(variablename)
```

### Replacing/changing a variables value
If you need to change a variables value you just put a new value in it. Then the old value will be removed automatically.

Write and run this code:
```lua
stringname = "number of tracks: "
variablename = 24

reaper.ShowConsoleMsg(stringname)
reaper.ShowConsoleMsg(variablename)

stringname = "initial number of tracks: "
variablename = 0
reaper.ShowConsoleMsg(stringname)
reaper.ShowConsoleMsg(variablename)
```

As you can see we print the variable `stringname` two times, but because we change the value stored in it between the print-calls, it is reflected in the console output.

Let's say we want to know what value a variable is currently storing. Unlike `stringname` the containername `variablename` does not indicate what it holds.
To know the valuetype of a variable we can use the method `type`.

Type and run the following line:
```lua
reaper.ShowConsoleMsg(variablename)
```
The method type returns a valuetype of the variable that we pass to it, but since we just called the function without printing it, we don't see it's result in the console output.

Let's store it in a variable and print it:
```lua
variabletype = type(variablename)
reaper.ShowConsoleMsg(variabletype)
```

If we do not need to store the value for anything other than printing it, we can avoid it and just move the whole `type()` method inside of the `print` method.
```lua
reaper.ShowConsoleMsg(type(variablename))
```

### The execution order of a script
From the code above it is clear that Lua is executing the script in a certain order -> it starts from the top and executes downwards, **line by line** - only **one thing at a time**.

> About errors and execution order: <br> If errors happen the script will either not run, or it will stop executing at the exact spot in the code where the error happens. This means that the code below the error will not run, while the code above still executes. This can lead to confusion so be aware that the script might 'look like' it executes, even though it still fails somewhere and prevents parts of the code frome executing.

### All the types
While there are more, these are the different types of values we will use in this tutorial:

- **String**<br>
A sequence of characters, often used for text - contains characters, numbers or symbols.

- **number**<br>
Is numeric values

- **boolean**<br>
Is either “true” or “false”

- userdata<br>
Raw block of data that represents for example a track or item

- table<br>
Stores multiple values together

- nil<br>
Represents the absence of a value

We will learn these types through the tutorial.

> Lua is a "dynamically typed language" meaning a variable can hold any type of value and its type can change at runtime. Therefore we never need to worry about declaring a "variable type". Therefore, unlike languages such as C#, you don’t need to declare a variable type explicitly.

## Conditions
Sometimes we want a program to perform differently depending on the circumstances and situation. In the context of Reaper we might want to run different code depending on what is selected (track, items, etc.). Setting up rules like this can be done using **conditions**.

With conditions *we predefine a set of rules* in the code that the program checks in order to determine what code it should run.

So in all it's simplicity, we basically tell the program when it should - or shouldn’t - do something.

### Creating a condition
For this example let's use the valuetype *boolean* to create a condition.
As mentioned earlier, a boolean value is either *true* or *false*.

Lets create a boolean named "boolvar" and assign the value "true" to it:
```lua
boolvar = true
```

For this example we will define a rule so the lines of code containing `ShowConsoleMsg` only executes *if* the boolean is true.

Let's create a simple *if*-statement that prints "condition was met" to the console if the boolean `boolvar` is true:
```lua
if boolvar == true then
	reaper.ShowConsoleMsg("condition was met")
end
```

Let's add some of our variables from earlier:
```lua
if boolvar == true then
	reaper.ShowConsoleMsg("condition was met")
	reaper.ShowConsoleMsg(stringname)
	reaper.ShowConsoleMsg(variablename)
end
```

Here we basically tell the program to check if `boolvar` ***is equal*** to true and if it is we execute the code between ***then*** and ***end***.

If we wan't the program to execute a different set of actions if this condition is false (e.g. `boolvar`is not true) we add `else` to the statement, like this:
```lua
if boolvar == true then
	reaper.ShowConsoleMsg("condition was met")
	reaper.ShowConsoleMsg(stringname)
	reaper.ShowConsoleMsg(variablename)
else
	reaper.ShowConsoleMsg("condition was not met")
end
```

That's a basic **if-statement**. There are many more ways to write conditions but for now we will focus on this specific one.

### Comparison operators
In the above example we used `==`to define that the left side (in this case the variable) should be equal to the right side (in this case `true`). This is called a comparison operator and is often used in conditions.

It is called a **comparison operator** (or relational operator) because it compares the two values with each other.

All comparison operators are:
```lua
< (smaller than)
<= (smaller than or equal to)
> (bigger than)
>= (bigger than or equal to)
== (equal to)
~= (the negation of)
```

## Tables and Loops
We often need the computer to deal with several instances (like multiple selected items) at the same time. We use ***Arrays*** and ***Loops*** to do this.

- ***Arrays***: stores multiple values together.
- ***Loops***: can repeat code multiple times.

The array (which you may have heard before) of the Lua language is called ***Tables***.
The type of loop we will learn about is the ***For Loop***.

### Repeting code with the *for loop*
Loops is simply iterating through the same code multiple times. There are many ways to do this. We will use the *for loop*.

```lua
for i = 1, 10 do
	print(i)
end
```

Here we use `i = 1` to define the start, and `10` defines what number `i` should reach before the loop repetition ends.

The above code would print this to the console:
```
1
2
3
4
5
6
7
8
9
10
```

If we change the iterator beginning point, like this:
```lua
for i = 5, 10 do
	print(i)
end
```
We get this instead:
```
5
6
7
8
9
10
```

### Storing multiple values in *tables*
In order to store multiple values together we use *tables*. We create a table using `{}` and then we can put values in it immediately or later in the code.

Let's create a table called `items`:
```lua
items = {}
```

If we want to put values in it, we do it inside the `{}` and we use `,` as a separator between items:
```lua
items = {
	"item one",
	"item two",
	"item three"
}
```

As an alternative we can use the `table.insert` method like this:
```lua
items = {}
table.insert("item one")
table.insert("item two")
table.insert("item three")
```

> Putting it directly inside the curly brackets replaces the table with a new table, while the `table.insert` method, just adds new item values to the table.

The table stores two values: a *key*(), and a *value* related to that key.
### Looping through a *table*
If we want to get information from or manipulate all the items in a table, we can iterate through the table using the `pairs` function.

The syntax for the `pairs` function look like this (using the table `items` we created earlier):
```lua
for key, value in pairs(items) do
	print(key, value)
end
```

Running the above code the console will output this (maybe in a different order):
```
1	item one
2	item two
3	item three
```

So the `pairs` function actually knows when the loop ends (when there are no more items to iterate through).

# Writing a Reaper script from scratch
## Pseudocode

Before we go into the final part of syntax we need to learn, let's talk a little bit about approaches to writing code.

### Our practice script
As an example to demonstrate the creation of a script, we will create a script that applies a random volume to all currently selected audio clips.

I order to plan our process we will use what is called *pseudocode*.

Pseudocode is the concept of dividing a larger programming task into smaller steps. We do this to stay structured so we only have to keep our attention at one simple task at a time. By dealing with one simple task at a time we can also better handle potential errors, since they are more likely to be happening at the exact line of code we are working on.

When programming - as a rule of thumb - we always have to keep in mind that the computer is very unintelligent. It needs to be told every micro step along the way.

### Full pseudocode
So let's plan our volume variation script and write it in pseudocode.

```lua
-- create table (to store selected audio items)

-- get selected media items
    -- count selected media items
    -- loop through selected items
        -- store item temporarily
        -- check if item is an audio or midi item
        -- if audio item, store item in table

-- set audio items rnd volume change
-- loop through items in table
        -- generate new random value
        -- set item to new random volume
        -- set items to generated colorcode
```

### In steps
#### Prepare for loop
We somehow need to know how many items we have selected, in order for us to tell Reaper how many times to loop through it:
```lua
-- get selected media items
    -- count selected media items
    
```

#### Loop through selected items
Then afterwards we can create a loop so we can get information and manipulate every individual item as we want:
```lua
-- get selected media items
    -- count selected media items
    -- loop through selected items
        -- store item in a temporary variable
```
#### Find the audio items and put them in a table
Let's make sure to create a table before the loop so it is accesible in the entire script (and not just the loop). Then we can insert the audio only items (found inside the loop) into the table:
```lua
-- create table (to store selected audio items)

-- get selected media items
    -- count selected media items
    -- loop through selected items
        -- store item in a temporary variable
        -- check if item is an audio or midi item
        -- if it is an audio item, store the item in table
```
#### Loop through and apply random volume to audio items

```lua
-- create table (to store selected audio items)

-- get selected media items
    -- count selected media items
    -- loop through selected items
        -- store item temporarily
        -- check if item is an audio or midi item
        -- if audio item, store item in table

-- set audio items rnd volume change
-- loop through items in table
        -- generate new random value
        -- set item to new random volume
```
#### Apply random color to changed items
Let's also add a random color to the items we have manipulated (as an indicator of change):
```lua
-- create table (to store selected audio items)

-- get selected media items
    -- count selected media items
    -- loop through selected items
        -- store item temporarily
        -- check if item is an audio or midi item
        -- if audio item, store item in table

-- set audio items rnd volume change
-- loop through items in table
        -- generate new random value
        -- set item to new random volume
        -- generate random colorcode
        -- set items to generated colorcode
```

Even though the above example might seem too simple to divide in even smaller steps, it is a very good approach to learn, and get in the habit of using, because real-world scenarios are almost always complex. It is also very likely that some steps will be divided further when we start writing the code.