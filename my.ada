-- Ahmed Abd-Allah
-- CSCI 571, Fall 1993

-- FILE: MY.ADA (main file)

with Text_IO;
use  Text_IO;

with Generic_Urn;

-- package for handling strings and reading from files
with TextPkg;
use TextPkg;

-- packages for the classes
with Engineer;
use Engineer;
with Manager;
use Manager;
with Company;
use Company;
with Department;
use Department;
with Project;
use Project;
with Product;
use Product;


procedure Main is

------------------------------------------------------------------------------------

    -- parts of this procedure are from the code distributed by Brad Clark
    procedure Load_File is
      -- I will declare a really big line here to hold any string input from a file
      Big_Data : Text(256);
      -- I will declare a small line to hold a word
      p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11 : Text(30);

      -- I use a string of size 30 for everything to make it simpler.
      Mode : Text(30);

      -- Ada refers to file by a handle of type Text_IO.File_Type
      Data_File : File_Type;

      Len : Natural;
    begin
      -- First open the file and initialize the handle (from package Text_IO)

      Open(Data_File, In_File, "project.data");

      -- Read to the end of the file
      while not End_Of_File(Data_File) loop
	   -- Get a line from the file
	   Get_Line(Data_File, Big_Data.Line, Big_Data.Len);

           -- Check if a new section of data is next (e.g. #Company or #Department)
           -- see my project.data file for a better understanding
	   if Big_Data.Line(1..1) = "#" then
	      Mode.Len := Big_Data.Len;
	      Mode.Line(1..Big_Data.Len) := Big_Data.Line(1..Big_Data.Len);
	   else
              -- depending on the mode, scan for different types of fields.
	      if Mode.Line(1..Mode.Len) = "#Company" then

      	      	 Get_Word(Big_Data, p1);
      	      	 Get_Word(Big_Data, p2);
      	      	 Get_Word(Big_Data, p3);
      	      	 Get_Word(Big_Data, p4);
      	      	 Get_Word(Big_Data, p5);

                 -- create a unified address field (city,state)
		 Len := p3.Len + p4.Len;
		 p3.Line(1..Len) := p3.Line(1..p3.len) & p4.Line(1..p4.len);
		 p3.Len := Len;

                 -- insert the new object
		 Company.Insert( p1, p2, p3, p5 );

	      elsif Mode.Line(1..Mode.Len) = "#Department" then

      	      	 Get_Word(Big_Data, p1);
      	      	 Get_Word(Big_Data, p2);
      	      	 Get_Word(Big_Data, p3);

		 Department.Insert( p1, p2, p3 );

	      elsif Mode.Line(1..Mode.Len) = "#Manager" then

      	      	 Get_Word(Big_Data, p1);
      	      	 Get_Word(Big_Data, p2);
      	      	 Get_Word(Big_Data, p3);
      	      	 Get_Word(Big_Data, p4);
      	      	 Get_Word(Big_Data, p5);
      	      	 Get_Word(Big_Data, p6);
      	      	 Get_Word(Big_Data, p7);
      	      	 Get_Word(Big_Data, p8);

		 Len := p3.Len + p4.Len;
		 p3.Line(1..Len) := p3.Line(1..p3.len) & p4.Line(1..p4.len);
		 p3.Len := Len;

		 Manager.Insert( p1, p2, p3, p5, p6, p7, p8 );

	      elsif Mode.Line(1..Mode.Len) = "#Project" then

      	      	 Get_Word(Big_Data, p1);
      	      	 Get_Word(Big_Data, p2);
      	      	 Get_Word(Big_Data, p3);
      	      	 Get_Word(Big_Data, p4);
      	      	 Get_Word(Big_Data, p5);

		 Project.Insert( p1, p2, p3, p4, p5 );

	      elsif Mode.Line(1..Mode.Len) = "#Product" then

      	      	 Get_Word(Big_Data, p1);
      	      	 Get_Word(Big_Data, p2);
      	      	 Get_Word(Big_Data, p3);
      	      	 Get_Word(Big_Data, p4);
      	      	 Get_Word(Big_Data, p5);
      	      	 Get_Word(Big_Data, p6);
      	      	 Get_Word(Big_Data, p7);
      	      	 Get_Word(Big_Data, p8);

		 Product.Insert( p1, p2, p3, p4, p5, p6, p7, p8 );

	      elsif Mode.Line(1..Mode.Len) = "#Engineer" then

      	      	 Get_Word(Big_Data, p1);
      	      	 Get_Word(Big_Data, p2);
      	      	 Get_Word(Big_Data, p3);
      	      	 Get_Word(Big_Data, p4);
      	      	 Get_Word(Big_Data, p5);
      	      	 Get_Word(Big_Data, p6);
      	      	 Get_Word(Big_Data, p7);
      	      	 Get_Word(Big_Data, p8);
      	      	 Get_Word(Big_Data, p9);
      	      	 Get_Word(Big_Data, p10);
      	      	 Get_Word(Big_Data, p11);

		 Len := p3.Len + p4.Len;
		 p3.Line(1..Len) := p3.Line(1..p3.len) & p4.Line(1..p4.len);
		 p3.Len := Len;

		 Engineer.Insert( p1, p2, p3, p5, p6, p7, p8, p9, p10, p11 );

	      end if;

	   end if;
      end loop;

   end Load_File;

------------------------------------------------------------------------------------

   -- converts from "$X,XXX,XXX" (string) to XXXXXXX (number)
   function MoneyToNatural( Money : in Text ) return Natural is
      M, I : Natural := 0;
      S : Natural := 1;
      Stripped : Text(30);

   begin
      if Money.Len = 0 or Money.Line(1) /= '$' then
	 return 0;
      end if;

      I := 2;
      while I <= Money.Len loop
         -- look for digits
	 if Money.Line(I) >= '0' and Money.Line(I) <= '9' then
	    Stripped.Line(S) := Money.Line(I);
	    Stripped.Len := Stripped.Len + 1;
	    S := S + 1;
	 elsif Money.Line(I) /= ',' then
	    return 0;
	 end if;
	 I := I + 1;
      end loop;
      
      M := Natural'Value( Stripped.Line(1..Stripped.Len) );

      return M;
   end MoneyToNatural;

------------------------------------------------------------------------------------

-- main menu subprogram
procedure Menu is
   Command : Character := 'a';
   TC : Character;
   TN : Natural;
   TI, TI2 : Integer;
   TS : String(1..10);
   TT : Text(40);
   TF : Float;

   -- pointers to serve as workhorses
   cptr : comptr := null;
   dptr : depptr := null;
   mptr : manptr := null;
   pdptr: prdptr := null;
   pjptr: prjptr := null;
   eptr : engptr := null;

   -- instantiate IO for integers
   package Num_IO is new Integer_IO(Integer);
   Num, D, T, C, O : Natural;

   package F_IO is new Float_IO(Float);

   Seed : Positive := 2;
   function Urn is new Generic_Urn( Seed, Float );

   function RandomInt( Min : in Integer; Max : in Integer ) return Integer is
      F : Float;
      Interval, Result : Integer;
   begin
     Interval := Max - Min + 1;
     if Interval < 2 then
        return Min;
     end if;
     F := Urn * Float( Interval );

     Result := Integer( F );	-- convert to integer thru truncation
     if Float(Result) > F then
	Result := Result - 1;
     end if;

     Result := Result + Min;
     return Result;     
   end RandomInt;

   function IntToChar( I : in Integer ) return Character is
      C : Character;
   begin
      case I is
	 when 0 =>
	      return '0';
	 when 1 =>
	      return '1';
	 when 2 =>
	      return '2';
	 when 3 =>
	      return '3';
	 when 4 =>
	      return '4';
	 when 5 =>
	      return '5';
	 when 6 =>
	      return '6';
	 when 7 =>
	      return '7';
	 when 8 =>
	      return '8';
	 when 9 =>
	      return '9';
	 when others =>
	      return '?';
      end case;
   end IntToChar;

   procedure IntToText( Int : in Integer; Str : in out Text ) is
     Digit, Place : Integer;
     Num : Integer;
     TempString : String(1..40);
     begin
       if Int = 0 then
	  Str.Line(1) := '0';
	  Str.Len := 1;
	  return;
       elsif Int < 0 then
	  Num := - Int;
       else
       	  Num := Int;
       end if;

       Place := 1;
       Str.Len := 0;

       -- convert the integer into a string (reversed though)
       while Num > 0 loop
       	 Digit := Num mod 10;
	 Str.Line(Place) := IntToChar(Digit);
	 Place := Place + 1;
	 Str.Len := Str.Len + 1;
	 Num := Num / 10;
       end loop;

       -- reverse the string
       if Str.Len > 0 then
       	 Num := Str.Len;
	 TempString(1..Str.Len) := Str.Line(1..Str.Len);
	 if Int < 0 then
	    Str.Line(1) := '-';
	    while Num > 0 loop
	       Str.Line( Str.Len - Num + 2 ) := TempString( Num );
	       Num := Num - 1;
	    end loop;
	    Str.Len := Str.len + 1;
	 else
	    while Num > 0 loop
	       Str.Line( Str.Len - Num + 1 ) := TempString( Num );
	       Num := Num - 1;
	    end loop;
	 end if;
       end if;
   end IntToText;

begin

   while Command /= 'z' loop

      New_Line;
--      Set_Page_Length( 20 );
--      New_Page;
--      Set_Col( 20 );
--      Set_Line( 20 );
      Put_Line( "*** Command Menu ***" );
      Put_Line( "====================" );
      Put_Line( "   a. LOAD Project.data" );
      Put_Line( "   b. LIST Projects" );
      Put_Line( "   c. LIST Products" );
      Put_Line( "   d. LIST Engineers" );
      Put_Line( "   e. SELECT Name from Products where Status=DESIGN" );
      Put_Line( "   f. SELECT Name from Projects where Budget > 500,000" );
      Put_Line( "   g. SELECT Engineer.Name, Product.Name From Engineer," );
      Put_Line( "      Product where Engineer.title=designer and" );
      Put_Line( "      Engineer.Works_on=Product and Product.Status=DESIGN" );
      Put_Line( "   h. SELECT Product.Name from Products, Managers" );
      Put_Line( "      where Manager.Name=Cindy" );
      Put_Line( "   i. STATISTICS Cost from Product where Project=Alpha" );
      Put_Line( "   j. STATISTICS Status from Product where Project=Alpha" );
      Put_Line( "   k. STATISTICS Project.Budget from Project, Company" );
      Put_Line( "      where Company.Name=IBM" );
      Put_Line( "   l. Weird stuff" );
      Put_Line( "   z. QUIT" );
      New_Line;
      Put( "Enter Letter for Command: " );
      Get( Command );

      case Command is 
	 when 'a' =>
	      begin
	      	Load_File;
		Put_Line( "Data successfully loaded." );
		New_Line;
	      end;
	 when 'b' =>
	      begin
	      	pjptr := project.first_project;

		Put_Line( "Information Retrieved:" );
		New_Line;
		Put_Line( "Name, Budget, Belongs_To, Managed_By" );
		Put_Line( "------------------------------------" );

                -- traverse the linked list of projects, printing the info.
		while pjptr /= null loop
		   Put( pjptr.name.line(1..pjptr.name.len) & ", " );
		   Put( pjptr.budget.line(1..pjptr.budget.len) & ", ");
		   Put( pjptr.belongsto.line(1..pjptr.belongsto.len) & ", ");
		   Put_Line( pjptr.managedby.line(1..pjptr.managedby.len) );
		   pjptr := pjptr.next;
		end loop;

	      end;
	 when 'c' =>
	      begin
	      	pdptr := product.first_product;

		Put_Line( "Information Retrieved:" );
		New_Line;
		Put_Line( "Name, Status, Cost, Version, CPCI, Produced_By, Owned_By" );
		Put_Line( "--------------------------------------------------------" );

		while pdptr /= null loop
		   Put( pdptr.name.line(1..pdptr.name.len) & ", " );
		   Put( pdptr.status.line(1..pdptr.status.len) & ", ");
		   Put( pdptr.costtodate.line(1..pdptr.costtodate.len) & ", ");
		   Put( pdptr.version.line(1..pdptr.version.len) & ", ");
		   Put( pdptr.cpci.line(1..pdptr.cpci.len) & ", " );
		   Put( pdptr.producedby.line(1..pdptr.producedby.len) & ", ");
		   Put_Line( pdptr.ownedby.line(1..pdptr.ownedby.len) );
		   pdptr := pdptr.next;
		end loop;

	      end;
	 when 'd' =>
	      begin
	      	eptr := engineer.first_engineer;

		Put_Line( "Information Retrieved:" );
		New_Line;
		Put_Line( "Name, Address, Phone, SSN, Works_For, Title, Belongs_To, Works_On, Joins_In" );
		Put_Line( "---------------------------------------------------------------------------" );

		while eptr /= null loop
		   Put( eptr.name.line(1..eptr.name.len) & ", " );
		   Put( eptr.address.line(1..eptr.address.len) & ", ");
		   Put( eptr.phone.line(1..eptr.phone.len) & ", ");
		   Put( eptr.ssn.line(1..eptr.ssn.len) & ", " );
		   Put( eptr.worksfor.line(1..eptr.worksfor.len) & ", " );
		   Put( eptr.title.line(1..eptr.title.len) & ", ");
		   Put( eptr.belongsto.line(1..eptr.belongsto.len) & ", ");
		   Put( eptr.workson.line(1..eptr.workson.len) & ", " );
		   Put_Line( eptr.joinsin.line(1..eptr.joinsin.len) );
		   eptr := eptr.next;
		end loop;

	      end;
	 when 'e' =>
	      begin
	      	pdptr := product.first_product;

		Put_Line( "Information Retrieved:" );
		New_Line;
		Put_Line( "Name" );
		Put_Line( "----" );

		while pdptr /= null loop
		   if pdptr.status.line(1..pdptr.status.len) = "Design" then
		      Put_Line( pdptr.name.line(1..pdptr.name.len) );
		   end if;
		   pdptr := pdptr.next;
		end loop;

	      end;
	 when 'f' =>
	      begin
	      	pjptr := project.first_project;

		Put_Line( "Information Retrieved:" );
		New_Line;
		Put_Line( "Name" );
		Put_Line( "----" );

		while pjptr /= null loop
		   Num := MoneyToNatural( pjptr.budget );
		   --Num_IO.Put(Num,7);  -- there is no Put_Line for integers
		   if Num > 500_000 then
		      Put_Line( pjptr.name.line(1..pjptr.name.len) );
		   end if;
		   pjptr := pjptr.next;
		end loop;

	      end;
	 when 'g' =>
	      begin
	        eptr := engineer.first_engineer;

		Put_Line( "Information Retrieved:" );
		New_Line;
		Put_Line( "Engineer-Product Name" );
		Put_Line( "---------------------" );
		
		while eptr /= null loop
		   if eptr.title.line(1..eptr.title.len) = "Designer" then

		      pdptr := product.Find( eptr.workson );
		      if pdptr /= null then
			 if pdptr.status.line(1..pdptr.status.len) = "Design" then
			    Put_Line( eptr.name.line(1..eptr.name.len) & "-" &
				      pdptr.name.line(1..pdptr.name.len) );
			 end if;
		      end if;

		   end if;
		   eptr := eptr.next;
		end loop;

	      end;
	 when 'h' =>
	      begin
	      	pdptr := product.first_product;

		Put_Line( "Information Retrieved:" );
		New_Line;
		Put_Line( "Name" );
		Put_Line( "----" );

		while pdptr /= null loop
		   pjptr := Project.Find( pdptr.producedby );
		   mptr := Manager.Find( pjptr.managedby );

		   if mptr.name.line(1..mptr.name.len) = "Cindy" then
		      Put_line( pdptr.name.line(1..pdptr.name.len) );
		   end if;
		   pdptr := pdptr.next;
		end loop;

	      end;
	 when 'i' =>
	      begin
	      	pdptr := product.first_product;

		Put_Line( "Information Retrieved:" );
		New_Line;
		Put_Line( "Total Cost" );
		Put_Line( "----------" );

		Num := 0;
		while pdptr /= null loop
		   if pdptr.producedby.line(1..pdptr.producedby.len) = "Alpha" then
		      Num := Num + MoneyToNatural( pdptr.costtodate );
		   end if;
		   pdptr := pdptr.next;
		end loop;
		Num_IO.Put(Num,10);  -- there is no Put_Line for integers
		New_line;
	      end;
	 when 'j' =>
	      begin
	      	pdptr := product.first_product;

		Put_Line( "Information Retrieved:" );
		New_Line;
		Put_Line( "Design, Coding, Testing, Operational" );
		Put_Line( "------------------------------------" );

		D := 0;
		C := 0;
		T := 0;
		O := 0;
		while pdptr /= null loop
		   if pdptr.producedby.line(1..pdptr.producedby.len) = "Alpha" then
		      if pdptr.status.line(1..pdptr.status.len) = "Design" then
			 D := D + 1;
		      end if;
		      if pdptr.status.line(1..pdptr.status.len) = "Coding" then
			 C := C + 1;
		      end if;
		      if pdptr.status.line(1..pdptr.status.len) = "Testing" then
			 T := T + 1;
		      end if;
		      if pdptr.status.line(1..pdptr.status.len) = "Operational" then
			 O := O + 1;
		      end if;
		   end if;
		   pdptr := pdptr.next;
		end loop;
		Num_IO.Put(D,1);
		Put(", ");
		Num_IO.Put(C,1);
		Put(", ");
		Num_IO.Put(T,1);
		Put(", ");
		Num_IO.Put(O,1);
		New_Line;
	      end;
	 when 'k' =>
	      begin
	      	pjptr := project.first_project;

		Put_Line( "Information Retrieved:" );
		New_Line;
		Put_Line( "Total Budget" );
		Put_Line( "------------" );
		
		Num := 0;
		while pjptr /= null loop
		   dptr := Department.Find( pjptr.belongsto );
		   cptr := Company.Find( dptr.ownedby );
		   if cptr.name.line(1..cptr.name.len) = "IBM" then
		      Num := Num + MoneyToNatural( pjptr.budget );
		   end if;
		   pjptr := pjptr.next;
		end loop;
		Num_IO.Put(Num, 10);  -- there is no Put_Line for integers
		New_line;

	      end;
	 when 'l' =>
	      begin
	      	TC := '0';
		TN := 9;
		TS(1) := TC;
		TS(2) := IntToChar ( TN );
		Put( "Assignments: " );
		Put( "TC is " & TC & ", ");
		Put( "TN is " & IntToChar(TN) & ", " );
		Put_Line( "TS is " & TS(1..2) );

		loop
		Put( "Enter Min: " );
		Num_IO.Get( TI );
		Put( "Enter Max: " );
		Num_IO.Get( TI2 );
--		IntToText( TI, TT ); 
		TI := RandomInt( TI, TI2 );
		Put_Line( "Random Int generated: " & Integer'Image( TI ) );
--		Put_Line( "You Entered: " & TT.Line(1..TT.Len) );
		end loop;

--		Put_line( Integer'Image( TI ) );

--		TI := 100;
--		loop
--		TI := TI + RandomInt( -1, 1 );
--		Put_Line( Integer'Image( TI ) );
--		delay 0.25;
--		end loop;

		New_Line;
	      end;
	 when 'z' =>
	      begin
	      	null;
	      end;
	 when others => null;
      end case;

   end loop;

end Menu;

begin

    Menu;

end Main;



