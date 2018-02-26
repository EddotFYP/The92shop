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
                int custId = rs.getInt(1);
                String name = rs.getString(2);
                //String gender = rs.getString(3);
                //String birthDate = rs.getString(4);
                String phoneNum = rs.getString(3);
                String address = rs.getString(4);
                String postalCode = rs.getString(5);
                result = new Customer(custId, name, phoneNum, address, postalCode);

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
                int retrievedCustId = rs.getInt(1);
                String name = rs.getString(2);
                //String gender = rs.getString(3);
                //String birthDate = rs.getString(4);
                String phoneNum = rs.getString(5);
                String address = rs.getString(6);
                String postalCode = rs.getString(7);
                result = new Customer(retrievedCustId, name, phoneNum, address, postalCode);

            }
            db.closeConn();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public ArrayList<Customer> retrieveCustomerList(String custName) {
        ArrayList<Customer> custList = new ArrayList<>();

        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("select * from customer where name like ?");
            stmt.setString(1, custName + '%');
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int custId = rs.getInt(1);
                String name = rs.getString(2);
                //String gender = rs.getString(3);
                //String birthDate = rs.getString(4);
                String phoneNum = rs.getString(3);
                String address = rs.getString(4);
                String postalCode = rs.getString(5);

                custList.add(new Customer(custId, name, phoneNum, address, postalCode));

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return custList;
    }

    public ArrayList<Customer> retrieveAllCustomers() {
        ArrayList<Customer> custList = new ArrayList<>();
        DatabaseConnection db = new DatabaseConnection();
        Connection conn = db.getConn();

        try {
            PreparedStatement stmt = conn.prepareStatement("select * from customer");
            ResultSet rs = stmt.executeQuery();
            
            while(rs.next()){
                int custId = rs.getInt(1);
                String name = rs.getString(2);
                String phoneNum = rs.getString(3);
                String address = rs.getString(4);
                String postalCode = rs.getString(5);
                custList.add(new Customer(custId, name,phoneNum,address, postalCode));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        db.closeConn();
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
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO customer VALUES (?,?,?,?,?)");

            stmt.setInt(1, c.getCustId());
            stmt.setString(2, c.getName());
            //stmt.setString(3, c.getGender());
            //stmt.setString(4, c.getBirthDate());
            stmt.setString(3, c.getPhoneNum());
            stmt.setString(4, c.getAddress());
            stmt.setString(5, c.getPostalCode());

            updateQuery = stmt.executeUpdate();

            db.closeConn();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return updateQuery;

    }

    public int editCustomer(int id, String newPhone, String newAddress, String newPostal) {
        int updateQuery = 0;
        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("UPDATE customer SET Phone_number = ?, Address = ?, Postal_Code = ? where Cust_Id = ?");

            stmt.setString(1, newPhone);
            stmt.setString(2, newAddress);
            stmt.setString(3, newPostal);
            stmt.setInt(4, id);

            updateQuery = stmt.executeUpdate();

            db.closeConn();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return updateQuery;

    }
}
