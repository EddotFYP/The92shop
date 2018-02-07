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
public class ExpenseTypes {
    private String expType;
    
    public ExpenseTypes(String expType){
        this.expType = expType;
    }
    
    public String getExpType(){
        return expType;
    }
    
    public void setExpType(String expType){
        this.expType = expType;
    }
    
}
