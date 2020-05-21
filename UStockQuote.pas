{-------------------------------------------------------------------------------
  Unit:    UStockQuote
  Purpose: Class representation for QuoteEndpoint API endpoint
  Author:  Andre Penedo
  Date:    2020-May-21
  Version: 1.0
-------------------------------------------------------------------------------}
unit UStockQuote;

interface

{$M+}
{$TYPEINFO ON}

type
  TStockQuote = class(TObject)
  private
    FSymbol: string;
    FOpen: Currency;
    FHigh: Currency;
    FLow: Currency;
    FPrice: Currency;
    FVolume: Integer;
    FLastTradeDate: TDate;
    FPreviouClose: Currency;
    FChange: Currency;
    FChangePercent: Currency;
  public
    constructor Create(Symbol: string; Open: Currency; High: Currency;
                       Low: Currency; Price: Currency; Volume: Integer;
                       LastTradeDate: TDate; PreviousClose: Currency;
                       Change: Currency; ChangePercent: Currency);
    destructor Destroy; override;
  published
    property symbol: string read FSymbol;
    property open: Currency read FOpen;
    property high: Currency read FHigh;
    property low: Currency read FLow;
    property price: Currency read FPrice;
    property volume: Integer read FVolume;
    property lastTradeDate: TDate read FLastTradeDate;
    property previousClose: Currency read FPreviouClose;
    property change: Currency read FChange;
    property changePercent: Currency read FChangePercent;
  end;

implementation

{-------------------------------------------------------------------------------
  Procedure: Create
  Author: Andre Penedo
  Date: 2020-May-21
  Arguments: Symbol: string;
             Open: Currency;
             High: Currency;
             Low: Currency;
             Price: Currency;
             Volume: Integer;
             LastTradeDate: TDate;
             PreviousClose: Currency;
             Change: Currency;
             ChangePercent: Currency
  Result:
-------------------------------------------------------------------------------}
constructor TStockQuote.Create(Symbol: string; Open: Currency; High: Currency;
  Low: Currency; Price: Currency; Volume: Integer; LastTradeDate: TDate;
  PreviousClose: Currency; Change: Currency; ChangePercent: Currency);
begin
  FSymbol := Symbol;
  FOpen := Open;
  FHigh := High;
  FLow := Low;
  FPrice := Price;
  FVolume := Volume;
  FLastTradeDate := LastTradeDate;
  FPreviouClose := PreviousClose;
  FChange := Change;
  FChangePercent := ChangePercent;
end;

{-------------------------------------------------------------------------------
  Procedure: Destroy
  Author: Andre Penedo
  Date: 2020-May-21
  Arguments:
  Result:
-------------------------------------------------------------------------------}
destructor TStockQuote.Destroy;
begin

end;

end.
