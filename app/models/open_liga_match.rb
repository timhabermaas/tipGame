class OpenLigaMatch
  extend Savon::Model

  document "http://www.OpenLigaDB.de/Webservices/Sportsdata.asmx?WSDL"

  def self.all
    client.request(:wsdl, :get_matchdata_by_league_saison) do
      soap.body = { "leagueShortcut" => "em12", "leagueSaison" => "2012" }
    end[:get_matchdata_by_league_saison_response][:get_matchdata_by_league_saison_result][:matchdata]
  end
end
