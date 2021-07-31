<!--#include file=OpenDbConn.asp-->
<%
    call OpenDbConn()

    dim BookName
    dim CategoryId
    dim AuthorId
    dim PublisherId
    dim LanguageId
    dim BookPages
    dim CabinetId
    dim ShelveId
    dim NewCategory
    dim NewAuthor
    dim NewPublisher
    dim Quantity

    BookName = Request.Form("FormBookName")
    CategoryId = cint(Request.Form("FormCategoryId"))
    AuthorId = cint(Request.Form("FormAuthorId"))
    PublisherId = cint(Request.Form("FormPublisherId"))
    LanguageId = cint(Request.Form("FormLanguageId"))
    BookPages = Request.Form("FormBookPages")
    CabinetId = cint(Request.Form("FormCabinetId"))
    ShelveId = cint(Request.Form("FormShelveId"))
    NewCategory = Request.Form("FormNewCategory")
    NewAuthor = Request.Form("FormNewAuthor")
    NewPublisher = Request.Form("FormNewPublisher")
    Quantity = Request.Form("FormQuantity")

    Session("Error") = ""
    Dim QryStr
    QryStr = ""

    if len(BookName) <= 0 then
        Session("Error") = "Book Name cannot be NULL"
        response.redirect("AddNewBook.asp")
    end if

    if len(BookPages) <= 0 then
        Session("Error") = "Book Pages cannot be NULL"
        response.redirect("AddNewBook.asp")
    end if

    if CategoryId = -1 then
        Session("Error") = "Category cannot be NULL"
        response.redirect("AddNewBook.asp")
    end if

    if AuthorId = -1 then
        Session("Error") = "Author cannot be NULL"
        response.redirect("AddNewBook.asp")
    end if

    if PublisherId = -1 then
        Session("Error") = "Publisher cannot be NULL"
        response.redirect("AddNewBook.asp")
    end if

    if LanguageId = -1 then
        Session("Error") = "Language cannot be NULL"
        response.redirect("AddNewBook.asp")
    end if

    if len(Quantity) = 0 then
        Quantity = 1
    end if

    if CategoryId = -2 then
        if len(NewCategory) <= 0 then
            Session("Error") = "New Category cannot be NULL"
            response.redirect("AddNewBook.asp")
        else
            Dim RSCategory
            Set RSCategory = Server.CreateObject("ADODB.RecordSet")
            RSCategory.Open "SELECT * FROM ListCategory",conn

            do while NOT RSCategory.EOF
                if RSCategory("Category") = NewCategory then
                    Session("Error") = "Duplicate Category Found"
                    response.redirect("AddNewBook.asp")
                    end if
            RSCategory.MoveNext
            loop
        end if
        RSCategory.Close

        QryStr = "INSERT INTO ListCategory(Category) VALUES('" & NewCategory & "')"
        'response.write(QryStr)
        Conn.Execute QryStr

        RSCategory.Open "SELECT TOP(1) PERCENT * FROM ListCategory ORDER BY CategoryId DESC",conn
        CategoryId = RSCategory("CategoryId")
        RSCategory.Close
    end if

    if AuthorId = -2 then
        if len(NewAuthor) <= 0 then
            Session("Error") = "New Author cannot be NULL"
            response.redirect("AddNewBook.asp")
        else
            Dim RSAuthor
            Set RSAuthor = Server.CreateObject("ADODB.RecordSet")
            RSAuthor.Open "SELECT * FROM ListAuthor",conn

            do while NOT RSAuthor.EOF
                if RSAuthor("AuthorName") = NewAuthor then
                    Session("Error") = "Duplicate Author Found"
                    response.redirect("AddNewBook.asp")
                    end if
            RSAuthor.MoveNext
            loop
        end if
        RSAuthor.Close

        QryStr = "INSERT INTO ListAuthor(AuthorName) VALUES('" & NewAuthor & "')"
        'response.write(QryStr)
        Conn.Execute QryStr

        RSAuthor.Open "SELECT TOP(1) PERCENT * FROM ListAuthor ORDER BY AuthorId DESC",conn
        AuthorId = RSAuthor("AuthorId")
        RSAuthor.Close
    end if

    if PublisherId = -2 then
        if len(NewPublisher) <= 0 then
            Session("Error") = "New Publisher cannot be NULL"
            response.redirect("AddNewBook.asp")
        else
            Dim RSPublisher
            Set RSPublisher = Server.CreateObject("ADODB.RecordSet")
            RSPublisher.Open "SELECT * FROM ListPublisher",conn

            do while NOT RSPublisher.EOF
                if RSPublisher("Publisher") = NewPublisher then
                    Session("Error") = "Duplicate Publisher Found"
                    response.redirect("AddNewBook.asp")
                    end if
            RSPublisher.MoveNext
            loop
        end if
        RSPublisher.Close

        QryStr = "INSERT INTO ListPublisher(Publisher) VALUES('" & NewPublisher & "')"
        'response.write(QryStr)
        Conn.Execute QryStr

        RSPublisher.Open "SELECT TOP(1) PERCENT * FROM ListPublisher ORDER BY PublisherId DESC",conn
        PublisherId = RSPublisher("PublisherId")
        RSPublisher.Close
    end if

    QryStr = "INSERT INTO BooksDetail(BookName, CategoryId, LanguageId, AuthorId, PublisherId, BookPages, Quantity, CabinetId, ShelveId)" & _
            " VALUES('" & BookName & "', " & CategoryId & ", " & LanguageId & ", " & AuthorId & ", " & PublisherId & ", " & BookPages & ", " & Quantity & ", " & CabinetId & ", " & ShelveId & ")" 

    response.write(QryStr)
    Conn.Execute QryStr
    response.redirect("BooksDetail.asp")
%>