== MyRhouse

* Author: Fernand Galiana
* Source: git://github.com/derailed/my_rhouse.git
* Discussions: http://groups.google.com/group/rhouse_gem  
    
== DESCRIPTION:

 This is a supporting gem for the RHouse home automation gem. It provides
 some examples of things you can do with ruby in your home. This gem provide an
 example rules engine for intercepting device events and taking action when a 
 rule is fired. This gem uses Ruleby (git://github.com/mattup/ruleby.git)

== FEATURES/PROBLEMS:

* Peachy so far...

== SYNOPSIS:

 The gem provides sample code for writing a rhouse worker. A Rhouse worker is
 an executable to monitors a beanstalk queue and observes events that are being
 pushed on that queue. The worker in this case package the event and matches it
 with a set of 'canned rules' when a certain event occurs. This is purely sample
 code to assist you in experimenting with Rhouse. This is still work in progress, 
 we'll add more examples in the near future.
 
== REQUIREMENTS:

* LinuxMCE home automation system
* Rhouse gem installed

== INSTALL:

  sudo gem install my_rhouse

== LICENSE:

(The MIT License)

Copyright (c) 2008 FIXME (different license?)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
