/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author Jacquelyn
 */
public class ExpenseTracker {
    private String date;
    private String expenseType;
    private String remark;
    private String cost;

    public ExpenseTracker(String date, String expenseType, String remark, String cost) {
        this.date = date;
        this.expenseType = expenseType;
        this.remark = remark;
        this.cost = cost;
    }
    public String getDate() {
        return date;
    }

    public String getExpenseType() {
        return expenseType;
    }

    public String getRemark() {
        return remark;
    }

    public String getCost() {
        return cost;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public void setExpenseType(String expenseType) {
        this.expenseType = expenseType;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public void setCost(String cost) {
        this.cost = cost;
    }
    


 

}
