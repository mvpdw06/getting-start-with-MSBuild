# Getting Start with MSBuild  

## 目標

1. 使用 windows batch script 編譯 ASP.NET server-side code。
2. 不需使用 VisualStudio。
3. 在 windwos command line 中呈現編譯結果。

## 需求

1. Windwos 作業系統。
2. 安裝 .NET framework (需要比你的專案更高或是一樣的 .NET framework 版本即可)。
3. ASP.NET server-side code 在你的電腦裡面。

## 設定步驟

1. 先讓 windows command line 了解 MSBuild 這個指令。

通常就算安裝了 .NET framework 你也只會有 MSBuild 這個 exe，但 windows 並不認識他，要讓他認識的方法就是把 MSBuild 的路徑加入 windows 的環境變數當中。

那麼重新開啟 windows command line 就會有 MSBuild 的指令囉！

```
MSBuild
```

2. 了解 MSBuild 的參數。

通常我們會用到幾個參數

* path

可以指定專案 .sln 檔案的路徑ㄋ，也可以是 .csproj 專案的路徑，但通常專案之間都有設定相依性，所以直接指定 .sln 檔案即可處理掉相依性的問題。

```
MSBuild D://Dev/MyProject/project.sln
```

* /target

可簡寫為 /t，在專案中建置指定的目標或是分別指定的目標。

指定編譯方法：Compile / Clean / Rebuild

```
/t Rebuild
```

* /property

可以簡寫為 /p，設定或覆寫所指定的專案層級屬性，由 name = value 組成。

指定編譯模式：Debug / Release

```
/p Configuration="Debug"
```

編譯使用 CPU：Any CPU / x86

```
/p Platform="Any CPU"
```

* /consoleloggerparameters

定義在 command line 中顯示編譯資訊。


```
/consoleloggerparameters:PerformanceSummary;NoSummary
```

* /verbosity

定義在編譯過程與結果中顯示的資訊量。


```
/verbosity:minimal
```


更多屬性請看 [MSBuild 命令列參考](https://msdn.microsoft.com/zh-tw/library/ms164311.aspx)

3. 執行 batch script。

## 進階設定

> 設定一套指令從 svn 更新 > 停用 IIS > MSBuild 編譯 > 啟用 IIS

1. svn 更新

如果你是透過 svn 作為版本控管系統，那麼可以順便安裝 svn 的 clint command line 套件，那麼在 windwos 的 command line 就會有 svn 的指令囉！

```
svn update [your project path]
```

2. 停用 IIS

這裡停用 IIS 的用意是，如果你的 ASP.NET 專案掛在 IIS 上，那麼有可能會因為 web.config 被 IIS 正在使用，導致編譯失敗。（此情況不一定會發生，要依照你專案上的設定而定）

```
IISRESET STOP
```

3. MSBuild 編譯

利用上方學到的 MSBuild script 來編譯。

```
MSBuild
```

4. 啟用 IIS 

如果上方停用了 IIS，那麼這邊就是把它再重新打開！（如果你不需要停止 IIS，那麼你也同樣不需要開啟）

```
IISRESET START
```

## References

1. [MSBuild](https://msdn.microsoft.com/zh-tw/library/0k6kkbsd.aspx) in MSDN.


