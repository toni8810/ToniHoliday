package flights.eu.toniholiday;

public class Flight {
	private String dateOutbound;
	private String dateInbound;
	private int numberOfNights;
	private double priceOutbound;
	private double priceInbound;
	private String priceOutboundInForeignCurrency;
	private String priceInboundInForeignCurrency;
	private String flightCompanyOutbound;
	private String flightCompanyInbound;
	private double aggregatePrice;
	public String getDateOutbound() {
		return dateOutbound;
	}
	public void setDateOutbound(String dateOutbound) {
		this.dateOutbound = dateOutbound;
	}
	public String getDateInbound() {
		return dateInbound;
	}
	public void setDateInbound(String dateInbound) {
		this.dateInbound = dateInbound;
	}
	public double getPriceOutbound() {
		priceOutbound = Math.round(priceOutbound*100);
		priceOutbound /= 100;
		return priceOutbound;
	}
	public void setPriceOutbound(double priceOutbound) {
		this.priceOutbound = priceOutbound;
	}
	public double getPriceInbound() {
		priceInbound = Math.round(priceInbound*100);
		priceInbound /= 100;
		return priceInbound;
	}
	public void setPriceInbound(double priceInbound) {
		this.priceInbound = priceInbound;
	}
	public String getFlightCompanyOutbound() {
		flightCompanyOutbound = flightCompanyOutbound.substring(0, 1).toUpperCase() + flightCompanyOutbound.substring(1);
		return flightCompanyOutbound;
	}
	public String getFlightCompanyOutboundWithLowercase() {
		return flightCompanyOutbound;
	}
	public void setFlightCompanyOutbound(String flightCompanyOutbound) {
		this.flightCompanyOutbound = flightCompanyOutbound;
	}
	public String getFlightCompanyInbound() {
		flightCompanyInbound = flightCompanyInbound.substring(0, 1).toUpperCase() + flightCompanyInbound.substring(1);
		return flightCompanyInbound;
	}
	public String getFlightCompanyInboundWithLowercase() {
		return flightCompanyInbound;
	}
	public void setFlightCompanyInbound(String flightCompanyInbound) {
		this.flightCompanyInbound = flightCompanyInbound;
	}
	public double getAggregatePrice() {
		aggregatePrice = priceInbound + priceOutbound;
		aggregatePrice = Math.round(aggregatePrice*100);
		aggregatePrice /= 100;
		return aggregatePrice;
	}
	public String getPriceOutboundInForeignCurrency() {
		return priceOutboundInForeignCurrency;
	}
	public void setPriceOutboundInForeignCurrency(String priceOutboundInForeignCurrency) {
		this.priceOutboundInForeignCurrency = priceOutboundInForeignCurrency;
	}
	public String getPriceInboundInForeignCurrency() {
		return priceInboundInForeignCurrency;
	}
	public void setPriceInboundInForeignCurrency(String priceInboundInForeignCurrency) {
		this.priceInboundInForeignCurrency = priceInboundInForeignCurrency;
	}
	public int getNumberOfNights() {
		return numberOfNights;
	}
	public void setNumberOfNights(int numberOfNights) {
		this.numberOfNights = numberOfNights;
	}
}
