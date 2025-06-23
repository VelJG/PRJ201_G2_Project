package db;

import java.util.List;

public class RevenueResponse {
    private List<String> months;
    private List<Double> monthlyRevenues;

    public RevenueResponse(List<String> months, List<Double> monthlyRevenues) {
        this.months = months;
        this.monthlyRevenues = monthlyRevenues;
    }

    public List<String> getMonths() {
        return months;
    }

    public List<Double> getMonthlyRevenues() {
        return monthlyRevenues;
    }
}
