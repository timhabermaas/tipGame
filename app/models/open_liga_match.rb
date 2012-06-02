class OpenLigaMatch
  extend Savon::Model

  document "http://www.OpenLigaDB.de/Webservices/Sportsdata.asmx?WSDL"

  attr_accessor :match_id, :match_date_time_utc, :group_id, :group_order_id, :group_name, :name_team1,
                :name_team2, :points_team1, :points_team2, :match_is_finished, :match_results

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

  def points_first_half_team1
    half_time_results[:points_team1].try(:to_i)
  end

  def points_first_half_team2
    half_time_results[:points_team2].try(:to_i)
  end

private
  def half_time_results
    results = @match_results[:match_result] if @match_results
    if results
      results.find { |r| r[:result_order_id].to_i == 2}
    else
      {}
    end
  end
end
