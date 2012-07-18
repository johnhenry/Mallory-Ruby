#Mallory - MA(th) ll (f)O(r) R(ub)Y
Version: 0.5
##About
Mallory is a ruby library/gem that allows for advanced mathematical and statistical computation using the standard IRB REPL or other Ruby-based REPLs.
Mallory can also be embedded in other applications in which Ruby is the language of choice.

##History
Mallory started off as a project based in ActionScript for use in Flash projects. `http://code.google.com/p/mallory/`
Due to decline in the usage of the Flash plugin, I've decide to take the project in a new direction.
I've chosen to re-develop the Mallory Project using Ruby due to the extensibility and increasing ubiquity of the language.


##Features
Mallory modifies existing ruby enviornments in the following ways:

1. Adding functionality to existing classes. Examples of additional functionality include:
	* Math's static methods have been extended to cover complex numbers
	* Arrays can be used to represent Matrices, Sets, and Data Tables
	* Arrays have been extended to calculate aggregate properties of the data they hold (mean, median, etc)
	* Hashes can be used to represent Premutations
	* Fixnum has been extended to include many properties of Integers (primality, decomposition, etc)
	* Complex's inspect method is changed to reflect a more "natural" representation
		* that is, Complex(2,4) is now represented as 2+4\*I where I = sqrt(-1)
	* Bindings can now be marshalled in order to save and resume sessions\*
		
2. Adding new classes to facilitate importing and exporting data
	* Export
		* Plot Class supports programmatic drawing on the command line
		* HTML Class supports creating interactive charts and graphs in html\*
	* Import
		* Read Class supports importing CSVs and other file types into Arrays as Data Tables\*
		* ReadNet Class supports importing data sets from various internet resources (random.org, oeis.org)\*
		* ReadDB Class supports importing data from databases (both local and online)\*

3. Modifying the REPL to work like existing programming enviornments used by mathemeticians, statisticians, and engineers
	* R\*
	* Matlab\*
	* Bash\*

\*Note: These features are still a work in progress