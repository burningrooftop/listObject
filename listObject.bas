' List Object

global List$
global Delim$
global LastError$

global #lib

run "functionLibrary", #lib

function debug$()
  debug$ = "List"
end function

function isnull()
  isnull = 0
end function

function new(delim$)
  if delim$ = "" then
    LastError$ = "Delimiter cannot be empty."
  else
    Delim$ = delim$
    List$ = ""
    new = 1
  end if
end function

function delimiter$()
  delimiter$ = Delim$
end function

function list$(delim$)
  ' Return list items delimited by delim$
  i = 1
  item$ = word$(List$, i, Delim$)
  while item$ <> ""
    if item$ = Delim$ then item$ = ""
    list$ = list$ + d$ + item$
    d$ = delim$
    i = i + 1
    item$ = word$(List$, i, Delim$)
  wend
end function

function lasterror$()
  lasterror$ = LastError$
end function

function count()
  ' Return the number of items in the list
  i = 1
  item$ = word$(List$, i, Delim$)
  while item$ <> ""
    i = i + 1
    item$ = word$(List$, i, Delim$)
  wend
  count = i - 1
end function

function item$(n)
  ' Return the nth item in the list 
  item$ = word$(List$, n, Delim$)
  if item$ = Delim$ then item$ = ""
end function

function first$()
  ' Return the first item in the list
  first$ = word$(List$, 1, Delim$)
end function

function last$()
  ' Return the last item in the list
  last$ = word$(List$, count(), Delim$)
end function

function add(item$)
  ' Add item(s) to the end of the list
  add = addLast(item$)
end function

function addAll(#source)
  ' Add all items in #source to the end of the list
  addAll = addAllLast(#source)
end function

function addAllFirst(#source)
  ' Add all items in #source to the start of the list
  if not(#source isnull()) then
    for i = #source count() to 1 step -1
      addAllFirst = addFirst(#source item$(i))
    next i
  end if
end function

function addAllLast(#source)
  ' Add all items in #source to the end of the list
  if not(#source isnull()) then
    for i = 1 to #source count()
      addAllLast = addLast(#source item$(i))
    next i
  end if
end function

function addFirst(item$)
  ' Add item(s) to the start of the list
  List$ = item$ + Delim$ + List$
  addFirst = 1
end function

function addLast(item$)
  ' Add item(s) to the end of the list
  List$ = List$ + item$ + Delim$
  addLast = 1
end function

function find(item$)
  ' Return the location of the item in the list or 0 if not found
  i = 1
  i$ = word$(List$, i, Delim$)
  while i$ <> ""
    if i$ = Delim$ then i$ = ""
    if item$ = i$ then
      find = i
      exit while
    end if
    i = i + 1
    i$ = word$(List$, i, Delim$)
  wend
end function

function findNext(item$, skip)
  ' Return the index of item in the list skipping some items
  i = 1
  i$ = word$(List$, i, Delim$)
  while i$ <> ""
    if i$ = Delim$ then i$ = ""
    if item$ = i$ and i > skip then
      findNext = i
      exit while
    end if
    i = i + 1
    i$ = word$(List$, i, Delim$)
  wend
end function

' ------------------
' Removing functions
' ------------------

function removeIndex(n)
  i = 1
  i$ = word$(List$, i, Delim$)
  while i$ <> ""
    if i$ = Delim$ then i$ = ""
    if i = n then
      removeIndex = 1
    else
      newList$ = newList$ + i$ + Delim$
    end if
    i = i + 1
    i$ = word$(List$, i, Delim$)
  wend
  if removeIndex = 0 then
    LastError$ = "Item not found."
  else
    List$ = newList$
  end if
end function

function removeFirst()
  removeFirst = removeIndex(1)
end function

function removeLast()
  removeLast = removeIndex(count())
end function

function remove(item$)
  ' Remove an item from the list
  i = 1
  i$ = word$(List$, i, Delim$)
  while i$ <> ""
    if i$ = Delim$ then i$ = ""
    if item$ = i$ and remove = 0 then
      remove = 1
    else
      newList$ = newList$ + i$ + Delim$
    end if
    i = i + 1
    i$ = word$(List$, i, Delim$)
  wend
  if remove = 0 then
    LastError$ = "Item not found."
  else
    List$ = newList$
  end if
end function

function removeAll(item$)
  ' Remove all instances of an item from the list
  i = 1
  i$ = word$(List$, i, Delim$)
  while i$ <> ""
    if i$ = Delim$ then i$ = ""
    if item$ = i$ then
      removeAll = 1
    else
      newList$ = newList$ + i$ + Delim$
    end if
    i = i + 1
    i$ = word$(List$, i, Delim$)
  wend
  if removeAll = 0 then
    LastError$ = "Item not found."
  else
    List$ = newList$
  end if
end function

function sort(reverse)
  ' Sort the list (descending sort if reverse is true)
  sqliteconnect #db, ":memory:"
  #db execute("CREATE TABLE list (item text)")

  i = 1
  item$ = word$(List$, i, Delim$)
  while item$ <> ""
    if item$ = Delim$ then item$ = "" 
    #db execute("INSERT INTO list VALUES (" + #lib quote$(item$) + ")")
    i = i + 1
    item$ = word$(List$, i, Delim$)
  wend

  sql$ = "SELECT item FROM list ORDER BY item"
  if reverse then sql$ = sql$ + " DESC"
  #db execute(sql$)
  List$ = ""
  while #db hasanswer()
    #row = #db #nextrow()
    List$ = List$ + #row item$() + Delim$
  wend

  #db disconnect()
end function
