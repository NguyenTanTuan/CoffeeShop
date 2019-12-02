package com.iviettech.coffeeshop.views;

import com.iviettech.coffeeshop.entities.OrderDetailEntity;
import com.iviettech.coffeeshop.entities.OrderEntity;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.servlet.view.document.AbstractXlsView;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author PC
 */
public class ExcelView extends AbstractXlsView {

    @Override
    protected void buildExcelDocument(Map model,
            Workbook wrkbk, HttpServletRequest hsr, HttpServletResponse response)
            throws Exception {
        List<OrderEntity> orders = (List<OrderEntity>) model.get("newOrders");
        response.setHeader("Content-Disposition", "attachment; filename=Export.xls");

        int i = 1;
        int j = 1;
        Sheet sheet = wrkbk.createSheet("List Orders");

//Order
        Row orderH = sheet.createRow(0);
        orderH.createCell(0).setCellValue("#");
        orderH.createCell(1).setCellValue("Order Id");
        orderH.createCell(2).setCellValue("Order date");
        orderH.createCell(3).setCellValue("Shipping date");
        orderH.createCell(4).setCellValue("Customer name");
        orderH.createCell(5).setCellValue("Customer address");
        orderH.createCell(6).setCellValue("Customer phone");
        orderH.createCell(7).setCellValue("Customer email");
        orderH.createCell(8).setCellValue("Total price");
        orderH.createCell(9).setCellValue("Status");
//Order-Detail

        for (OrderEntity order : orders) {
            Row orderR = sheet.createRow(i);
            orderR.createCell(0).setCellValue(i);
            orderR.createCell(1).setCellValue(order.getId());
            orderR.createCell(2).setCellValue(order.getOrderDate().toString());
            orderR.createCell(3).setCellValue(order.getShippingDate().toString());
            orderR.createCell(4).setCellValue(order.getCustomer().getName());
            orderR.createCell(5).setCellValue(order.getCustomer().getAddress());
            orderR.createCell(6).setCellValue(order.getCustomer().getPhone());
            orderR.createCell(7).setCellValue(order.getCustomer().getEmail());
            orderR.createCell(8).setCellValue(order.getTotalPrice());
            orderR.createCell(9).setCellValue(order.getStatus().toString());
            j=1;
            Sheet sheet2 = wrkbk.createSheet("Detail Order" + i);
            Row detailH = sheet2.createRow(0);
            detailH.createCell(0).setCellValue("#");
            detailH.createCell(1).setCellValue("Order id");
            detailH.createCell(2).setCellValue("Order detail id");
            detailH.createCell(3).setCellValue("Product Id");
            detailH.createCell(4).setCellValue("Product name");
            detailH.createCell(5).setCellValue("Quantity");
            detailH.createCell(6).setCellValue("Topping");
            detailH.createCell(7).setCellValue("Size");
            detailH.createCell(8).setCellValue("Price");
            detailH.createCell(9).setCellValue("Unit price");
            for (OrderDetailEntity item : order.getOrderDetails()) {
                Row detailR = sheet2.createRow(j);
                detailR.createCell(0).setCellValue(j);
                detailR.createCell(1).setCellValue(order.getId());
                detailR.createCell(2).setCellValue(item.getId());
                detailR.createCell(3).setCellValue(item.getProduct().getId());
                detailR.createCell(4).setCellValue(item.getProduct().getName());
                detailR.createCell(5).setCellValue(item.getQuantity());
                detailR.createCell(6).setCellValue(item.getTopping());
                detailR.createCell(7).setCellValue(String.valueOf(item.getSize()));
                detailR.createCell(8).setCellValue(item.getPrice());
                detailR.createCell(9).setCellValue(item.getUnitPrice());
                j++;

            }
            i++;
        }

    }

}
