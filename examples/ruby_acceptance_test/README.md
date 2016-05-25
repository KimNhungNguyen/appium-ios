To do list:
+ Make ENV for sauce access key
+ 


= Successfully make appium start up by itself before the test if it's not running in the background

= Fixing Appium Inspector: If you run 'appium --version' in terminal and it doesn't regconize appium's version, then there is something wrong with your appium. The simplest way to fix it is deleting it from Applications, then reinstall using package (not by 'npm install -g appium' as this makes it hard to detect and fix the problem
Choose the most update appium, for example, at the moment
it is appium 1.5.2: https://bitbucket.org/appium/appium.app/downloads/appium-1.5.2.dmg

This problem can leads to error message like: Appium Inspector not working: When launching Appium Inspector: The error message would be like:
Could not start a new session
Be sure the Appium server is running with an application opened by using the "App Path" parameter in Appium.app (along with package and activity for Android)... although App Path is correctly added via Appium GUI and also in conf file

= To kill an appium process:
'ps -A | grep appium'
'kill <process id>

= To connect appium with the app, just go to Appium GUI, then specify the app path and choose (by typing) the app version

= To run the app on CI:
+ Create a project on Github: follow the instruction of initialize a repo (inside sample-code). It first doesn't recognize you've got files and folders inside sample-code. You need create a README file, do the first commit. At that time, it will recognize the other folders/file in the local repo (sample-code). Add, commit and push all those files

Important note: Should not fork a repo, then work on it, because you may end up messing with the original repo (even you already delete .git and .gitinore folders which contain the connection of the original repo)

Think of travis CI as a computer that will run all command in .travis.yml the same way as you do it on command line/ terminal.

= To run the app on Sauce lab:
+ Need to upload the .app file as a TestApp.zip file onto an internet source that Sauce can connnect to and download. Note that the way Sauce download your app is like the way curl does on command line 'curl -O https://www.dropbox.com/s/jqc84l161dia7il/TestApp.zip?dl=1'. If curl is not successful, then it will not be successful on lab

Note: 
1. Upload to sauce storage is not working. So I choose to upload it into dropbox
2. The reason why I do not run from travis_ci to Saucelab as we rarely do CI to Saucelab.

= using CCMenu to watch the build on travis_ci:
Open CCMenu, choose Preference. Then '+' and add the following URL to access the CruiseControl feed. This is for public repo.
https://api.travis-ci.org/repos/KimNhungNguyen/appium-ios/cc.xml
There's another way for private repo

= Are there real devices on Sauce lab?
The Real Device Cloud is now available in beta for enterprise customers, with pricing starting at $449 per device per month.

= You can upload, download, zip a file via terminal. Learn that :-). It's not that difficult

= Tag: ~@ignore: not run the test with @ignore
= ENV variable: Default ruby có array ENV, đó là global array. Nếu thêm một element vào nó, thì co the truy xuất ở bất kỳ đâu. VD: ENV['RAKE_TASK'] = "some_string": nghĩa là thêm một element RAKE_TASK vào ENV, nó có giá trị là "some_string"


==> Questions:
+ Why app restart twice whenever it runs?
+ Why app automatically shut down after 1 minute?
+ Can we get an element by name? Or should we just use 'id' or 'xpath'?