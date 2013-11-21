# helpers-databags cookbook
This recipe brings in a `Helpers::DataBags` singleton


# Methods
### escape(__name__)
This method takes a string and escapes invalid data-bag characters int the following ways:
* dot to dash: `.` -> `-`
* space to underscore:` ` -> `_`

# Recipes
## default
  Does nothing, just makes sure the libs are loaded

# Author
Author:: Jesse Nelson (<spheromak@gmail.com>)
