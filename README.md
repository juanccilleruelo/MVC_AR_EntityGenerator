# MVC ActiveRecord Entity Generator (by senCille)

Tired of creating the descendants of TActiveRecord by hand?

https://github.com/juanccilleruelo/MVC_AR_EntityGenerator
Is an OpenSource project developed in Delphi XE 12 that takes the metadata of your Database and creates one class ActiveRecord of each Table in the Database.

You can generate the AR of one table or one AR class for each table in the Database. You can indicate in which folder the AR file should be deployed, and the program will remember it. 
Each AR is generated in an independent .pas file. 

And this is only the Beta version. 

You save all the information used to generate the AR; when you need to develop it again, you only need to use it. 

In the next version, we plan to implement more types of AR, like, for example, AR with a Master-Detail Relationship. 

In the current version, you can change the name of the Class generated. This is useful when you want, for example, the AR class representing one member of the entity Customers, instead of being named TCustomers, to be named TCustomer; that is more accurate. 

I want to implement, too, a connection with the AI (probably Chat-GPT) to ask directly for the translation of the plural table names to singular class names. In this target, I want the AI to modify the table name to respect the Camel Style of Pascal Class names. For example, a table named Items_Owned_by_user is currently created as TItemsownedbyuser. The AI can easily convert this to TItemsOwnedByUser, which is more accurate to the style of  Pascal code. 

And many more things can be made with an open-source project. Do you don't think it!!

Try it, and let us know what you think!

Thanks 

PD: The project is also an excellent example of using SQLite as a memory store for the data and treating this data as a standalone project, in contrast to the concept of a Database on Disk, which is more current in Delphi.

# Woring in progress... 

# Road Map
  1- Improve the modifications that the user can make to generate the ActiveRecord.
     (Eg: The name of the properties or the data type) 
     Sometimes, with SQLite databases, the data type suggested by the application is 
     not the most appropriate for the program. Ref: Dynamic Type System of SQLite.

  2- Implement how we are going to manage the modifications in the Real DB after
     we modified his data in the program. 
     (if a field disappeared, if there is a new field on DB or if a field definition
     has been modified) 
   
  2- Use of OpenAI IA connection for things like GetSingular Names for
     the entities and convert the names of the fields to Camel Style (Pascal).
