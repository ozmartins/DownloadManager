program DownloadManager.Test;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}
{$STRONGLINKTYPES ON}
uses
  System.SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ELSE}
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  {$ENDIF }
  DUnitX.TestFramework,
  Subject in '..\DownloadManager.Vcl\Source\Infra\Observer\Subject.pas',
  Observer in '..\DownloadManager.Vcl\Source\Infra\Observer\Observer.pas',
  SubjectTest in 'Source\Infra\Observer\SubjectTest.pas',
  MockObserver in 'Source\Infra\Observer\MockObserver.pas',
  HttpHeaderHelper in '..\DownloadManager.Vcl\Source\Infra\Network\HttpHeaderHelper.pas',
  InfraConsts in '..\DownloadManager.Vcl\Source\Infra\InfraConsts.pas',
  FileManager in '..\DownloadManager.Vcl\Source\Domain\FileManager.pas',
  FileManagerTest in 'Source\Domain\FileManagerTest.pas',
  GuidGenerator in '..\DownloadManager.Vcl\Source\Infra\GuidGenerator.pas',
  Downloader in '..\DownloadManager.Vcl\Source\Domain\Downloader.pas',
  DownloaderTest in 'Source\Domain\DownloaderTest.pas',
  MockNetHTTPRequest in 'Source\Infra\MockNetHTTPRequest.pas',
  SimpleNetHTTPRequest in '..\DownloadManager.Vcl\Source\Infra\Network\SimpleNetHTTPRequest.pas',
  MockHttpResponse in 'Source\Infra\MockHttpResponse.pas',
  LogDownload in '..\DownloadManager.Vcl\Source\Domain\LogDownload.pas',
  LogDownloadRepository in '..\DownloadManager.Vcl\Source\Infra\Repository\LogDownloadRepository.pas',
  SimpleNetHTTPRequestProxy in '..\DownloadManager.Vcl\Source\Infra\Network\SimpleNetHTTPRequestProxy.pas',
  MessageQueue in '..\DownloadManager.Vcl\Source\Infra\MessageQueue.pas',
  Repository in '..\DownloadManager.Vcl\Source\Infra\Repository\Repository.pas',
  RepositoryConsts in '..\DownloadManager.Vcl\Source\Infra\Repository\RepositoryConsts.pas',
  DomainConsts in '..\DownloadManager.Vcl\Source\Domain\DomainConsts.pas',
  ObserverConsts in '..\DownloadManager.Vcl\Source\Infra\Observer\ObserverConsts.pas';

{$IFNDEF TESTINSIGHT}
var
  runner: ITestRunner;
  results: IRunResults;
  logger: ITestLogger;
  nunitLogger : ITestLogger;
{$ENDIF}
begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
{$ELSE}
  try
    //Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    //Create the test runner
    runner := TDUnitX.CreateRunner;
    //Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;
    //When true, Assertions must be made during tests;
    runner.FailsOnNoAsserts := False;

    //tell the runner how we will log things
    //Log to the console window if desired
    if TDUnitX.Options.ConsoleMode <> TDunitXConsoleMode.Off then
    begin
      logger := TDUnitXConsoleLogger.Create(TDUnitX.Options.ConsoleMode = TDunitXConsoleMode.Quiet);
      runner.AddLogger(logger);
    end;
    //Generate an NUnit compatible XML File
    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);

    //Run tests
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    {$IFNDEF CI}
    //We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
    {$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
{$ENDIF}
end.
