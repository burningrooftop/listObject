# listObject
List object for Run Basic

### Requirements

* Run Basic 1.01
* functionLibrary

### Usage

```
run "listObject", #list

#list new("", ",") ' create an empty comma-delimited list
#list add("item") ' add an item to the list
#list add("more items,and more") ' can add multiple items
#list sort(0) ' sort list
print #list list$() ' print list contents
```

### Functions

#### new(list$, delim$)
Initialise the list. Set the list delimiter to *delim$* (which must not be empty) and the list contents to *list$*. Returns 1 on success or 0 on failure.

#### add(item$)
Add *item$* to the end of the list.
