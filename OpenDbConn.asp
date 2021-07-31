<%
    'OpenDbConn Procedure Start
    Dim Conn
    Dim CS
        Sub OpenDbConn()
            Set Conn = Server.CreateObject("ADODB.Connection")
            CS = "Driver={SQL Server};Server=NABEELS-WORK;Database=LibraryManagementSystem;User Id=LMS;Password=Nabeel30;"
            Conn.Open CS
        End Sub
    'End
%>