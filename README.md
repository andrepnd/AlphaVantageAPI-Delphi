# Alpha Vantage API - Delphi
Wrapper written in Delphi to get stock quotes from Alpha Vantage API

## Usage

```
var
  API: TAlphaVantageAPI;
  Stock: TStockQuote;
begin
  API := TAlphaVantageAPI.Create('your-key');
  Stock := API.QuoteEndpoint('ABEV3.SA');

  // your code

  FreeAndNil(API);
  FreeAndNil(Stock);
end;
```

## Contributing
Pull requests are welcome.

## License
[MIT](https://choosealicense.com/licenses/mit/)