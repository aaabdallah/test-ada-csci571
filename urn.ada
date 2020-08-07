            generic
               Seed : in out Positive;
               type Real is digits <>;
            function Generic_Urn return Real;

            function Generic_Urn return Real is

               a  : constant := 7**5;      --        16,807
               m  : constant := 2**31-1;   -- 2,147,483,647
               q  : constant := m / a;     --       127,773
               r  : constant := m mod a;   --         2,836
               hi,
               lo,
               test : Integer; -- must be 32 bits

            begin
               -- want: Seed := (a * Seed) mod m;
               -- but will overflow, so do it as follows:
               hi := seed / q;
               lo := seed mod q;
               test := a * lo - r * hi;
               if ( test < 0 ) then
                  Seed := test + m;
               else
                  Seed := test;
               end if;
               return Real(Seed) / Real(m);
            end Generic_Urn;
