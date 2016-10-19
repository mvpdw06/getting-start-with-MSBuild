@Echo Off

SVN update D:\Dev\MyProject

IISRESET STOP

@echo:

MSBuild  D:\Dev\MyProject\project.sln /t:Rebuild /p:Configuration="Debug" /p:Platform="Any CPU" /consoleloggerparameters:PerformanceSummary;NoSummary /verbosity:minimal

@echo:

IISRESET START

@echo:

Pause