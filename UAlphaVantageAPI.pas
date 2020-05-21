{-------------------------------------------------------------------------------
  Unit:    UAlphaVantageAPI
  Purpose: Wrapper for the Alpha Vantage API
  Author:  Andre Penedo
  Date:    2020-May-21
  Version: 1.0
-------------------------------------------------------------------------------}
unit UAlphaVantageAPI;

interface

uses
  System.JSON, System.Net.HttpClient, System.SysUtils,
  UStockQuote;

type
  TAlphaVantageAPI = class(TObject)
  private
    FApiKey: string;
    FFormatSettings: TFormatSettings;
    function DoRequest(ApiParams: string): TJSONObject;
  //protected

  public
    constructor Create(ApiKey: string);
    destructor Destroy; override;
    function QuoteEndpoint(Symbol: string): TStockQuote;
  //published

  end;

implementation

var
  FApiUrl: string = 'https://www.alphavantage.co/query?';
  FStrFunction: string = 'function=';
  FStrSymbol: string = '&symbol=';
  FStrApiKey: string = '&apikey=';

{-------------------------------------------------------------------------------
  Procedure: Create
  Author: Andre Penedo
  Date: 2020-May-21
  Arguments: ApiKey: string
  Result:
-------------------------------------------------------------------------------}
constructor TAlphaVantageAPI.Create(ApiKey: string);
begin
  FApiKey := ApiKey;

  FFormatSettings := TFormatSettings.Create('en-US');
  FFormatSettings.CurrencyDecimals := 4;
end;

{-------------------------------------------------------------------------------
  Procedure: Destroy
  Author: Andre Penedo
  Date: 2020-May-21
  Arguments:
  Result:
-------------------------------------------------------------------------------}
destructor TAlphaVantageAPI.Destroy;
begin

end;

{-------------------------------------------------------------------------------
  Procedure: DoRequest
  Author: Andre Penedo
  Date: 2020-May-21
  Arguments: ApiParams: string
  Result: TJSONObject
-------------------------------------------------------------------------------}
function TAlphaVantageAPI.DoRequest(ApiParams: string): TJSONObject;
var
  HTTP: THTTPClient;
  JSON: string;
  URL: string;
  JSONObject: TJSONObject;
begin
  URL := FApiUrl + ApiParams + FStrApiKey + FApiKey;

  HTTP := THTTPClient.Create;
  try
    JSON := HTTP.Get(URL).ContentAsString;
  finally
    HTTP.Free;
  end;

  JSONObject := TJSONObject.ParseJSONValue(JSON) as TJSONObject;
  Result := JSONObject;
end;

{-------------------------------------------------------------------------------
  Procedure: QuoteEndpoint
  Author: Andre Penedo
  Date: 2020-May-21
  Arguments: Symbol: string
  Result: TStockQuote

  This service returns the latest price and volume information for a security
  of your choice.

  Example of URL:
  https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=ABEV3.SA&apikey
  =demo
-------------------------------------------------------------------------------}
function TAlphaVantageAPI.QuoteEndpoint(Symbol: string): TStockQuote;
var
  APIFunction: string;
  APIParams: string;
  JSONObject: TJSONObject;
  GlobalQuote: TJSONObject;
  StockQuote: TStockQuote;

  ChangePercent: String;
begin
  APIFunction := 'GLOBAL_QUOTE';
  APIParams := FStrFunction + APIFunction + FStrSymbol + Symbol;

  JSONObject := DoRequest(APIParams);

  try
    GlobalQuote := JSONObject.GetValue('Global Quote') as TJSONObject;

    with GlobalQuote do
    begin
      ChangePercent := GetValue('10. change percent').Value;
      Delete(ChangePercent, Length(ChangePercent), 1);

      StockQuote := TStockQuote.Create(GetValue('01. symbol').Value,
        StrToCurr(GetValue('02. open').Value, FFormatSettings),
        StrToCurr(GetValue('03. high').Value, FFormatSettings),
        StrToCurr(GetValue('04. low').Value, FFormatSettings),
        StrToCurr(GetValue('05. price').Value, FFormatSettings),
        StrToInt(GetValue('06. volume').Value),
        StrToDate(GetValue('07. latest trading day').Value),
        StrToCurr(GetValue('08. previous close').Value, FFormatSettings),
        StrToCurr(GetValue('09. change').Value, FFormatSettings),
        StrToCurr(ChangePercent, FFormatSettings));
    end;

  finally
    JSONObject.Free;
  end;

  Result := StockQuote;
end;

end.
