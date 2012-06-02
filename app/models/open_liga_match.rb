class OpenLigaMatch
  extend Savon::Model

  document "http://www.OpenLigaDB.de/Webservices/Sportsdata.asmx?WSDL"

  attr_accessor :match_id, :match_date_time_utc, :group_id, :group_order_id, :group_name, :name_team1,
                :name_team2, :points_team1, :points_team2, :match_is_finished

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value) if respond_to?("#{name}=")
    end
  end

  def self.all
    client.request(:wsdl, :get_matchdata_by_league_saison) do
      soap.body = { "leagueShortcut" => "em12", "leagueSaison" => "2012" }
    end[:get_matchdata_by_league_saison_response][:get_matchdata_by_league_saison_result][:matchdata].map do |a|
      OpenLigaMatch.new a
    end
  end

  def points_team1
    if @points_team1.nil? or @points_team1.to_i < 0
      nil
    else
      @points_team1.to_i
    end
  end

  def points_team2
    if @points_team2.nil? or @points_team2.to_i < 0
      nil
    else
      @points_team2.to_i
    end
  end
end
