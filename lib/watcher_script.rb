# watch( '.' )  {|md| system("open 'http://0.0.0.0:3000'") }

watch( 'app|public' )  {|md| system("open -g 'http://0.0.0.0:3000'") }
