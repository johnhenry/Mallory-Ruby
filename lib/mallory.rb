#Load New Classes
Dir["../lib/mallory/*.rb"].each {|file| load file }
Dir["../lib/mallory/core_ext/*.rb"].each {|file| load file }
I = Complex::I