package com.example.rma.service.reports;

import com.example.rma.domain.dto.InstitutionDto;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

public class ReportExcelInstitutionDto{
    private final XSSFWorkbook workbook;
    private XSSFSheet sheet;
    private final List<InstitutionDto> institutionDtoList;
    private final String nameSheet;
    private final String reportName;

    public ReportExcelInstitutionDto(List<InstitutionDto> institutionDtoList, String nameSheet, String reportName) {
        this.reportName = reportName;
        this.workbook = new XSSFWorkbook();
        this.institutionDtoList = institutionDtoList;
        this.nameSheet = nameSheet;
    }

    private void writeHeaderLine() {
        sheet = workbook.createSheet(this.nameSheet);

        Row row = sheet.createRow(0);

        CellStyle style = workbook.createCellStyle();
        XSSFFont font = workbook.createFont();
        font.setBold(true);
        font.setFontHeight(16);
        style.setFont(font);

        createCell(row, 0, "Табельный номер", style);
        createCell(row, 1, "ФИО", style);
        createCell(row, 2, "Должность", style);
        createCell(row, 3, "Подразделение", style);
        createCell(row, 4, "Отработанные часы", style);
        createCell(row, 5, "Обязательные часы", style);
    }

    private void writeDataLines() {
        int rowCount = 1;

        CellStyle style = workbook.createCellStyle();
        XSSFFont font = workbook.createFont();
        font.setFontHeight(14);
        style.setFont(font);

        for (InstitutionDto institutionDto : institutionDtoList) {
            Row row = sheet.createRow(rowCount++);
            int columnCount = 0;

            createCell(row, columnCount++, institutionDto.getId(), style);
            createCell(row, columnCount++, institutionDto.getFullName(), style);
            createCell(row, columnCount++, institutionDto.getPositionName(), style);
            createCell(row, columnCount++, institutionDto.getSubdivisionName(), style);
            createCell(row, columnCount++, institutionDto.getSumActualluWork(), style);
            createCell(row, columnCount++, institutionDto.getObligatoryWorkTime(), style);

        }
    }


    private void createCell(Row row, int columnCount, Object value, CellStyle style) {
        sheet.autoSizeColumn(columnCount);
        Cell cell = row.createCell(columnCount);
        if (value instanceof Integer) {
            cell.setCellValue((Integer) value);
        } else if (value instanceof Boolean) {
            cell.setCellValue((Boolean) value);
        }else if (value instanceof Long) {
            cell.setCellValue((Long) value);
        }else if (value instanceof Double) {
            cell.setCellValue((Double) value);
        }
        else {
            cell.setCellValue((String) value);
        }
        cell.setCellStyle(style);
    }

    public void export(HttpServletResponse response) throws IOException {
        response.setContentType("application/octet-stream");

        String headerKey = "Content-Disposition";
        String headerValue = "attachment; filename=" + this.reportName+ ".xlsx";
        response.setHeader(headerKey, headerValue);
        writeHeaderLine();
        writeDataLines();

        ServletOutputStream outputStream = response.getOutputStream();
        workbook.write(outputStream);
        workbook.close();

        outputStream.close();

    }


}
