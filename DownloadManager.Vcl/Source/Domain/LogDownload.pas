unit LogDownload;

interface

type
  TLogDownload = class
  private
    fId : Int64;
    fUrl: String;
    fCompleteFileName: String;
    fStartDate: TDateTime;
    fFinishDate: TDateTime;
  public
    constructor Create(AId: Int64; AUrl, ACompleteFileName: String; AStartDate: TDateTime; AFinishDate: TDateTime);

    property Id : Int64 read fId;
    property Url : String read fUrl;
    property CompleteFileName : String read fCompleteFileName;
    property StartDate : TDateTime read fStartDate;
    property FinishDate : TDateTime read fFinishDate;
  end;

implementation

/// <summary>This method creates an instance of TLogDownload class.</summary>
/// <param name="AId">The log unique ID.</param>
/// <param name="AUrl">The URL was used to perform the download.</param>
/// <param name="AFilePath">The complete path to the file is saved on disk.</param>
/// <param name="AStartDate">The download's starting date and time.</param>
/// <param name="AFinishDate">The download's finishing date and time.</param>
/// <returns>Returns an instance of TLogDownload class.</returns>
constructor TLogDownload.Create(AId: Int64; AUrl, ACompleteFileName: String; AStartDate, AFinishDate: TDateTime);
begin
  fId := AId;
  fUrl := AUrl;
  fCompleteFileName := ACompleteFileName;
  fStartDate := AStartDate;
  fFinishDate := AFinishDate;
end;

end.
