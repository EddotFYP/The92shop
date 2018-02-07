/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import db.DatabaseConnection;
import entity.Customer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Clarey Liow JX
 */
public class CustomerDAO {

    private ArrayList<Customer> customers;

    public CustomerDAO() {

    }

    public Customer retrieve(String phoneNumber) {

        Customer result = null;

        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("select * from customer where Phone_number like ?");
            stmt.setString(1, phoneNumber + '%');
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String custId = rs.getString(1);
                String name = rs.getString(2);
                String gender = rs.getString(3);
                String birthDate = rs.getString(4);
                String phoneNum = rs.getString(5);
                String address = rs.getString(6);
                String postalCode = rs.getString(7);
                result = new Customer(custId, name, gender, birthDate, phoneNum, address, postalCode);

            }
            db.closeConn();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
    
    public Customer retrieveById(String custId) {

        Customer result = null;

        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("select * from customer where Cust_Id like ?");
            stmt.setString(1, custId + '%');
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                //String custId = rs.getString(1);
                String name = rs.getString(2);
                String gender = rs.getString(3);
                String birthDate = rs.getString(4);
                String phoneNum = rs.getString(5);
                String address = rs.getString(6);
                String postalCode = rs.getString(7);
                result = new Customer(custId, name, gender, birthDate, phoneNum, address, postalCode);

            }
            db.closeConn();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
    
    public ArrayList<Customer> retrieveCustomerList(String dateOfBirth) {
        ArrayList<Customer> custList = new ArrayList<>();

        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("select * from customer where Birthdate like ?");
            stmt.setString(1, dateOfBirth + '%');
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String custId = rs.getString(1);
                String name = rs.getString(2);
                String gender = rs.getString(3);
                String birthDate = rs.getString(4);
                String phoneNum = rs.getString(5);
                String address = rs.getString(6);
                String postalCode = rs.getString(7);

                custList.add(new Customer(custId, name, gender, birthDate, phoneNum, address, postalCode));

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return custList;
    }

    public void deleteCustomer(String phoneNumber) {

        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("delete from customer where Phone_number = ?");
            stmt.setString(1, phoneNumber);
            stmt.executeUpdate();
            db.closeConn();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public int addCustomer(Customer c) {
        int updateQuery = 0;
        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO customer VALUES (?,?,?,?,?,?,?)");
            
            stmt.setString(1, c.getCustId());
            stmt.setString(2, c.getName());
            stmt.setString(3, c.getGender());
            stmt.setString(4, c.getBirthDate());
            stmt.setString(5, c.getPhoneNum());
            stmt.setString(6, c.getAddress());
            stmt.setString(7, c.getPostalCode());

            updateQuery = stmt.executeUpdate();

            db.closeConn();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return updateQuery;

    }
    
    public int editCustomer(String id, String newPhone, String newAddress, String newPostal) {
        int updateQuery = 0;
        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("UPDATE customer SET Phone_number = ?, Address = ?, Postal_Code = ? where Cust_Id = ?");
            
            stmt.setString(1, newPhone);
            stmt.setString(2, newAddress);
            stmt.setString(3, newPostal);
            stmt.setString(4, id);

            updateQuery = stmt.executeUpdate();

            db.closeConn();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return updateQuery;

    }
}
