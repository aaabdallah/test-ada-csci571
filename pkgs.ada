-- Ahmed Abd-Allah
-- CSCI 571, Fall 1993

-- FILE: PKGS.ADA

with TextPkg;
use TextPkg;

-- packages that come close to being classes.  All access is public
package Engineer is 

   type fields;

   type engptr is access fields;

   type fields is record
     oid       : Text(30);
     name      : Text(30);
     address   : Text(30);
     phone     : Text(30);
     ssn       : Text(30);
     title     : Text(30);
     worksfor  : Text(30);
     belongsto : Text(30);
     workson   : Text(30);
     joinsin   : Text(30);
     next      : engptr := NULL; -- for creating a linked list of objects
   end record;

   first_engineer : engptr := null; -- head of the list

   procedure Insert( o, n, a, p, s, wf, t, be, wo, ji : in Text );
   function Find( o : in Text ) return engptr;

end Engineer;

package body Engineer is

   procedure Insert( o, n, a, p, s, wf, t, be, wo, ji : in Text ) is
      e : engptr := null;
   begin
      e := new fields; -- allocate a new object, then fill in the fields
      e.oid := o;
      e.name := n;
      e.address := a;
      e.phone := p;
      e.ssn := s;
      e.title := t;
      e.worksfor := wf;
      e.belongsto := be;
      e.workson := wo;
      e.joinsin := ji;
      e.next := first_engineer; -- append to the list
      first_engineer := e;
   end;

   function Find( o : in Text ) return engptr is
      e : engptr := null;
   begin

      e := first_engineer;
      while e /= null loop
         -- search by object id (should be unique).
	 if e.oid.line(1..e.oid.len) = o.line(1..o.len) then
	    return e;
         else
	    e := e.next;
	 end if;
      end loop;
      return e;
   end;

end Engineer;

with TextPkg;
use TextPkg;

package Manager is 

   type fields;

   type manptr is access fields;

   type fields is record
     oid       : Text(30);
     name      : Text(30);
     address   : Text(30);
     phone     : Text(30);
     ssn       : Text(30);
     worksfor  : Text(30);
     belongsto : Text(30);
     next      : manptr := NULL;
   end record;

   first_Manager : manptr := null;

   procedure Insert( o, n, a, p, s, wf, be : in Text );
   function Find( o : in Text ) return manptr;

end Manager;

package body Manager is

   procedure Insert( o, n, a, p, s, wf, be : in Text ) is
      e : manptr := null;
   begin
      e := new fields;
      e.oid := o;
      e.name := n;
      e.address := a;
      e.phone := p;
      e.ssn := s;
      e.worksfor := wf;
      e.belongsto := be;
      e.next := first_Manager;
      first_Manager := e;
   end;

   function Find( o : in Text ) return manptr is
      e : manptr := null;
   begin

      e := first_Manager;
      while e /= null loop
	 if e.oid.line(1..e.oid.len) = o.line(1..o.len) then
	    return e;
         else
	    e := e.next;
	 end if;
      end loop;
      return e;
   end;

end Manager;

with TextPkg;
use TextPkg;

package Product is 

   type fields;

   type prdptr is access fields;

   type fields is record
     oid       : Text(30);
     name      : Text(30);
     status    : Text(30);
     costtodate: Text(30);
     version   : Text(30);
     cpci      : Text(30);
     producedby: Text(30);
     ownedby   : Text(30);
     next      : prdptr := NULL;
   end record;

   first_Product : prdptr := null;

   procedure Insert( o, n, s, c, v, cp, pb, ob : in Text );
   function Find( o : in Text ) return prdptr;

end Product;

package body Product is

   procedure Insert( o, n, s, c, v, cp, pb, ob : in Text ) is 
      e : prdptr := null;
   begin
      e := new fields;
      e.oid := o;
      e.name := n;
      e.status := s;
      e.costtodate := c;
      e.version := v;
      e.cpci := cp;
      e.producedby := pb;
      e.ownedby := ob;
      e.next := first_Product;
      first_Product := e;
   end;

   function Find( o : in Text ) return prdptr is
      e : prdptr := null;
   begin

      e := first_Product;
      while e /= null loop
	 if e.oid.line(1..e.oid.len) = o.line(1..o.len) then
	    return e;
         else
	    e := e.next;
	 end if;
      end loop;
      return e;
   end;

end Product;

with TextPkg;
use TextPkg;

package Project is 

   type fields;

   type prjptr is access fields;

   type fields is record
     oid       : Text(30);
     name      : Text(30);
     budget    : Text(30);
     belongsto : Text(30);
     managedby : Text(30);
     next      : prjptr := NULL;
   end record;

   first_Project : prjptr := null;

   procedure Insert( o, n, b, be, mb : in Text );
   function Find( o : in Text ) return prjptr;

end Project;

package body Project is

   procedure Insert( o, n, b, be, mb : in Text ) is
      e : prjptr := null;
   begin
      e := new fields;
      e.oid := o;
      e.name := n;
      e.budget := b;
      e.belongsto := be;
      e.managedby := mb;
      e.next := first_Project;
      first_Project := e;
   end;

   function Find( o : in Text ) return prjptr is
      e : prjptr := null;
   begin

      e := first_Project;
      while e /= null loop
	 if e.oid.line(1..e.oid.len) = o.line(1..o.len) then
	    return e;
         else
	    e := e.next;
	 end if;
      end loop;
      return e;
   end;

end Project;

with TextPkg;
use TextPkg;

package Company is 

   type fields;

   type comptr is access fields;

   type fields is record
     oid       : Text(30);
     name      : Text(30);
     address   : Text(30);
     phone     : Text(30);
     next      : comptr := NULL;
   end record;

   first_Company : comptr := null;

   procedure Insert( o, n, a, p : in Text );
   function Find( o : in Text ) return comptr;

end Company;

package body Company is

   procedure Insert( o, n, a, p : in Text ) is
      e : comptr := null;
   begin
      e := new fields;
      e.oid := o;
      e.name := n;
      e.address := a;
      e.phone := p;
      e.next := first_Company;
      first_Company := e;
   end;

   function Find( o : in Text ) return comptr is
      e : comptr := null;
   begin

      e := first_Company;
      while e /= null loop
	 if e.oid.line(1..e.oid.len) = o.line(1..o.len) then
	    return e;
         else
	    e := e.next;
	 end if;
      end loop;
      return e;
   end;

end Company;

with TextPkg;
use TextPkg;

package Department is 

   type fields;

   type depptr is access fields;

   type fields is record
     oid       : Text(30);
     name      : Text(30);
     ownedby   : Text(30);
     next      : depptr := NULL;
   end record;

   first_Department : depptr := null;

   procedure Insert( o, n, ob : in Text );
   function Find( o : in Text ) return depptr;

end Department;

package body Department is

   procedure Insert( o, n, ob : in Text ) is
      e : depptr := null;
   begin
      e := new fields;
      e.oid := o;
      e.name := n;
      e.ownedby := ob;
      e.next := first_Department;
      first_Department := e;
   end;

   function Find( o : in Text ) return depptr is
      e : depptr := null;
   begin

      e := first_Department;
      while e /= null loop
	 if e.oid.line(1..e.oid.len) = o.line(1..o.len) then
	    return e;
         else
	    e := e.next;
	 end if;
      end loop;
      return e;
   end;

end Department;
