# listObject
List object for Run Basic

### Requirements

* Run Basic 1.01
* [functionLibrary](https://github.com/burningrooftop/functionLibrary)

### Usage

```
run "listObject", #list

#list new(",") ' create an empty comma-delimited list
#list add("item") ' add an item to the list
#list add("more items,and more") ' can add multiple items
#list sort(0) ' sort list
print #list list$(" ") ' print list contents space delimited
```

### Functions

#### new(delim$)
Initialise the list. Empties the list and set the list delimiter to *delim$* (which must not be empty). Returns 1 on success or 0 on failure.

#### count()
Returns the number of items in the list.

#### delimiter$()
Returns the list delimiter.

#### list$(delim$)
Returns all list items delimited by *delim$*.

#### first$()
Returns the first list item.

#### last$()
Returns the last list item.

#### item$(n)
Returns the *n*th item in the list.

#### find(item$)
Returns the index of *item$* in the list or 0 if not found.

#### findNext(item$, skip)
Returns the index of *item$* in the list, skipping the first *skip* items. Returns 0 if not found.

#### add(item$)
Add *item$* to the end of the list.

#### addFirst(item$)
Add *item$* to the start of the list.

#### addLast(item$)
Add *item$* to the end of the list.

#### addAll(#list)
Add all items in the list *#list#* to the end of the list.

#### addAllFirst(#list)
All add items in the list *#list* to the start of the list.

#### addAllLast(#list)
Add all items in the list *#list#* to the end of the list.

#### remove(item$)
Remove the first occurence of *item$* in the list. Returns 1 on success or 0 if not found.

#### removeAll(item$)
Removes all occurences of *item$* in the list. Returns 1 on success or 0 if not found.

#### removeIndex(n)
Remove the *n*th item in the list. Returns 1 on success or 0 if not found.

#### removeFirst()
Remove the first item in the list. Returns 1 on success or 0 if not found.

#### removeLast()
Remove the last item in the list. Returns 1 on success or 0 if not found.

#### sort(reverse)
Sort the list. If *reverse* is non zero, sort in descending order. Returns 1 on success, 0 otherwise.
