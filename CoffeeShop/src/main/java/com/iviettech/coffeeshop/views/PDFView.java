/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.iviettech.coffeeshop.views;

import com.iviettech.coffeeshop.entities.OrderDetailEntity;
import com.lowagie.text.Cell;
import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Table;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfWriter;
import java.awt.Color;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.view.document.AbstractPdfView;

/**
 *
 * @author admin
 */
public class PDFView extends AbstractPdfView {

    @Override
    protected void buildPdfDocument(Map model, Document doc, PdfWriter writer,
            HttpServletRequest request, HttpServletResponse response) throws Exception {

        ArrayList<OrderDetailEntity> orderDetails = (ArrayList<OrderDetailEntity>) model.get("orderDetails");
        SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy HH:mm");
        String pathUrl = request.getServletContext().getRealPath("/images");
        int index = pathUrl.indexOf("target");
        String pathToFont = pathUrl.substring(0, index) + "src//main//webapp//resources-management//fonts//Arial.ttf";
        BaseFont arial = BaseFont.createFont(pathToFont, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);

        Table table = new Table(3);
        table.setBorderColor(Color.WHITE);
        table.setBorderWidth(2);
        table.setPadding(2);
//        Add header for bill
        Cell header = new Cell(new Chunk("Teaffee shop", FontFactory.getFont(FontFactory.HELVETICA, 30)));
        header.setHeader(true);
        header.setColspan(3);
        header.setBorderColor(Color.WHITE);
        table.addCell(header);
        Cell headerChild = new Cell(new Chunk(format.format(new Date()), new Font(arial, 15, Font.BOLD)));
        headerChild.setHeader(true);
        headerChild.setColspan(3);
        headerChild.setBorderColor(Color.WHITE);
        table.addCell(headerChild);
//        Add header content item
        Cell cellH1 = new Cell(new Chunk("Sản phẩm", new Font(arial, 15, Font.BOLD)));
        cellH1.setBorderColorLeft(Color.WHITE);
        cellH1.setBorderColorRight(Color.WHITE);
        table.addCell(cellH1);

        Cell cellH2 = new Cell(new Chunk("Số lượng", new Font(arial, 15, Font.BOLD)));
        cellH2.setBorderColorLeft(Color.WHITE);
        cellH2.setBorderColorRight(Color.WHITE);
        cellH2.setHorizontalAlignment(Element.ALIGN_RIGHT);
        table.addCell(cellH2);

        Cell cellH3 = new Cell(new Chunk("Giá", new Font(arial, 15, Font.BOLD)));
        cellH3.setBorderColorLeft(Color.WHITE);
        cellH3.setBorderColorRight(Color.WHITE);
        cellH3.setHorizontalAlignment(Element.ALIGN_RIGHT);
        table.addCell(cellH3);
        for (OrderDetailEntity orderDetail : orderDetails) {
            String t = (!orderDetail.getTopping().isEmpty()) ? "\nThêm:" + orderDetail.getTopping() : "";
            Cell cell = new Cell(new Chunk(
                    String.format("%s(%s)" + t, orderDetail.getProduct().getName(), orderDetail.getSize().toString()),
                     new Font(arial, 10, Font.NORMAL)
            ));
            cell.setBorderColorLeft(Color.WHITE);
            cell.setBorderColorRight(Color.WHITE);
            table.addCell(cell);

            cell = new Cell(new Chunk(String.valueOf(orderDetail.getQuantity()), new Font(arial, 10, Font.NORMAL)));
            cell.setBorderColorLeft(Color.WHITE);
            cell.setBorderColorRight(Color.WHITE);
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(cell);

            cell = new Cell(new Chunk(String.valueOf(orderDetail.getPrice()), new Font(arial, 10, Font.NORMAL)));
            cell.setBorderColorLeft(Color.WHITE);
            cell.setBorderColorRight(Color.WHITE);
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(cell);
        }
        doc.add(table);
    }

}
