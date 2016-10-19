# Getting Start ~~踩地雷~~ with MSBuild

## 目標

1. 使用 windows batch script 編譯 ASP.NET server-side code。
2. 不需使用 VisualStudio。
3. 在 windwos command line 中呈現編譯結果。

## 需求

1. Windwos 作業系統。
2. 安裝 .NET framework (需要比你的專案更高或是一樣的 .NET framework 版本即可)。
3. ASP.NET server-side 專案在你的電腦裡面。

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
MSBuild D:\Dev\MyProject\project.sln
```

* /target

可簡寫為 /t，在專案中建置指定的目標或是分別指定的目標。

指定編譯方法： Compile / Clean / Rebuild

```
/t Rebuild
```

* /property

可以簡寫為 /p，設定或覆寫所指定的專案層級屬性，由 name = value 組成。

指定編譯模式： Debug / Release

```
/p Configuration="Debug"
```

指定編譯使用 CPU：Any CPU / x86 / x64

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

分為五種等級： quiet / minimal / Normal / Detailed / Diagnostic

各種等級差別請看 [You can configure the MSBuild verbosity in the Output window](https://blogs.msdn.microsoft.com/saraford/2008/10/07/did-you-know-you-can-configure-the-msbuild-verbosity-in-the-output-window-329/)

```
/verbosity:minimal
```


更多屬性請看 [MSBuild 命令列參考](https://msdn.microsoft.com/zh-tw/library/ms164311.aspx)

3. 執行 batch script。

這邊我們使用的設定有

* 指定編譯 .sln 檔案
* 使用 Rebuild
* 使用 Debug mode 編譯
* 使用 Any Cpu 來編譯
* 顯示效能摘要
* 不在結尾顯示警告與錯誤
* 顯示資訊量等級：minimal

```
MSBuild  D:\Dev\MyProject\project.sln /t:Rebuild /p:Configuration="Debug" /p:Platform="Any CPU" /consoleloggerparameters:PerformanceSummary;NoSummary /verbosity:minimal
```

## 你可能會遇到的問題

1. 用 MSbuild 編譯專案與使用 VisualStudio 有什麼不同？

其實使用 VisualStudio 編譯的時候，他也是呼叫對應的 MSBuild 來幫忙編譯，這一點你可以透過 VisualStudio 編譯時的「輸出」視窗看到這個結果！

> 目前我專案使用的是 VisualStudio 2013，其他版本有沒有不同我就不太了解了。

2. 使用 MSBuild 的好處是？

除了可以直接使用 script 做編譯以外，最重要的就是不需要開肥大的 VisualStudio 來拖慢編譯的速度 (尤其是你電腦沒有 SSD 的時候，光是開 VS 的速度...Orz)，但如果你開發的時候常常會需要寫 server-side 的 code 的話，還是要開 VisualStudio 來開發編譯會比較好。

3. 你會發現有些設定做了確沒有反應，尤其是針對 consoleloggerparameters 的部分

> 原因是因為：在你的專案檔 .sln 中已經有相同的設定，那麼你再這邊的 script 做設定就不會有反應。不過也沒關係，畢竟我們已經達到了我們用 command line 來編譯專案的目的了。

## 進階設定

> 設定一套指令 程式版本更新 > 停用 IIS > MSBuild 編譯 > 啟用 IIS

1. 程式版本更新

  版本控管軟體有很多套，這邊以 svn 為例，如果你是透過 svn 作為版本控管系統，那麼可以順便安裝 svn 的 clint command line 套件，那麼在 windwos 的 command line 就會有 svn 的指令囉！

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
  MSBuild  D:\Dev\MyProject\project.sln /t:Rebuild /p:Configuration="Debug" /p:Platform="Any CPU" /consoleloggerparameters:PerformanceSummary;NoSummary /verbosity:minimal
  ```

4. 啟用 IIS 

  如果上方停用了 IIS，那麼這邊就是把它再重新打開！（如果你不需要停止 IIS，那麼你也同樣不需要開啟）

  ```
  IISRESET START
  ```
  
> 我把範例 .bat 程式放在檔案中，可以隨意參考。

## References

1. [MSBuild](https://msdn.microsoft.com/zh-tw/library/0k6kkbsd.aspx) in MSDN.


