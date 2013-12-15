Continuous Integration on iOS with Jenkins
=========================================

__Description:__

This is a continuous integration example with an iOS application using xctool as the build system, CocoaPods as the dependency manager, AFNetworking for asynchronous networking inside the iOS app, OCMockito for mock and stub unit testing, OCHamcrest for unit testing matchers, gcovr for test coverage reporting, oclint for static analysis reporting, cloc for software lines of code count reporting, PMD for duplicate code reporting and Jenkins as the continuous integration server. I'll publish the detail setup for all these in my blog very soon.
 
__Building:__

In order to build the application, clone this repo:

```sh
$ git clone git@github.com:Ruenzuo/ios-ci-jenkins-example.git
```

Then set up the dependencies and open the workspace and you're ready to go:

```sh
$ cd ios-ci-jenkins-example && pod install && open WeatherApp.xcworkspace
```  

![screenshot-1](https://dl.dropboxusercontent.com/u/12352209/GitHub/ci-screenshot-1.png)&nbsp;
![screenshot-2](https://dl.dropboxusercontent.com/u/12352209/GitHub/ci-screenshot-2.png)
![screenshot-3](https://dl.dropboxusercontent.com/u/12352209/GitHub/ci-screenshot-3.png)

__Jenkins Dashboard:__

The main objective here is to have a quality metrics dashboard on Jenkins:  

![test_results](https://dl.dropboxusercontent.com/u/99114459/test_results.png)

![code_coverage](https://dl.dropboxusercontent.com/u/99114459/code_coverage.png)

![static_analysis](https://dl.dropboxusercontent.com/u/99114459/static_analysis.png)

![sloc_count](https://dl.dropboxusercontent.com/u/99114459/sloc_count.png)

![duplicate_code](https://dl.dropboxusercontent.com/u/99114459/duplicate_code.png)

You only need to add an Execute shell step on you Jenkins job like this:

```sh
./Scripts/Pods.sh
./Scripts/Coverage.sh
./Scripts/StaticAnalysis.sh
./Scripts/PMD.sh
./Scripts/Sloccount.sh
./Scripts/TestResults.sh
```

For more information on how to get started with each tool/framework, go to:  
xctool: https://github.com/facebook/xctool  
CocoaPods: https://github.com/cocoapods/cocoapods  
AFNetworking: https://github.com/AFNetworking/AFNetworking  
OCMockito: https://github.com/jonreid/OCMockito  
OCHamcrest: https://github.com/hamcrest/OCHamcrest  
gcovr: https://github.com/gcovr/gcovr  
oclint: https://github.com/oclint/oclint  
cloc: http://cloc.sourceforge.net  
PMD: http://pmd.sourceforge.net  
Jenkins: http://jenkins-ci.org/  

The following Jenkins plugins have been used for the dashboard:  
Test results: Regular Jenkins JUnit test result report plugin  
Code coverage: https://wiki.jenkins-ci.org/display/JENKINS/Cobertura+Plugin  
Static analysis: https://wiki.jenkins-ci.org/display/JENKINS/PMD+Plugin  
Sloc count: https://wiki.jenkins-ci.org/display/JENKINS/SLOCCount+Plugin  
Duplicate code: https://wiki.jenkins-ci.org/display/JENKINS/DRY+Plugin  

If you examine closely the scripts, this helpers tools have been used:  
reattach-to-user-namespace: https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard  
Objective-C-CPD-Language: https://github.com/jkennedy1980/Objective-C-CPD-Language  
xsltproc: https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/xsltproc.1.html  

__To-Do__

* `[✓]` <del>Make it public.</del>
* `[ ]` Write the blog post.
* `[ ]` Continuous delivery setup: app signing and Testflight integration.
* `[ ]` Currently, I'm executing the unit tests twice, because I'm using two different reporters each time. I think this could be improved.

License
=======

    The MIT License (MIT)

    Copyright (c) 2013 Renzo Crisóstomo

    Permission is hereby granted, free of charge, to any person obtaining a copy of
    this software and associated documentation files (the "Software"), to deal in
    the Software without restriction, including without limitation the rights to
    use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
    the Software, and to permit persons to whom the Software is furnished to do so,
    subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
    COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

