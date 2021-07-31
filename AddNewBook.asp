<!--#include file=OpenDbConn.asp-->

<%
call OpenDbConn()
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/GlobalStyle.css">
    <title>Add New Book</title>
</head>

<body style="background-color: #142e84;">
    <header>
        <!--#include file=Header.asp-->
    </header>

    <div class="wrapper">
        <div class="panel">
            <br>
            <div class="panel-head">
                <div class="row">
                    <div class="col">
                        <label for="">Add New Book</label>
                    </div>
                </div>
            </div>

            <div class="panel-body">
                <div class="container-fluid">
                    <form action="SaveNewBook.asp" method="POST">
                        <div class="row">
                            <div class="col-12">
                                <div class="form-group">
                                    <label for="" class="input-heading">Book Name</label>
                                    <input type="text" name="FormBookName" id="" class="form-control">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Category</label>
                                    <br>
                                    <select name="FormCategoryId" class="form-control" id="SelectCatg"
                                        onchange="ValidateOtherOption(this, document.getElementById('NewCategory'));">
                                        <option value="-1">Select Category</option>
                                        <option value="-2">Others</option>
                                        <%
                                                Dim RSCategory
                                                Set RSCategory = Server.CreateObject("ADODB.RecordSet")
                                                
                                                RSCategory.Open "SELECT * FROM ListCategory ORDER BY Category",Conn
            
                                                do while NOT RSCategory.EOF
                                            %>
                                        <option value="<% response.write(RSCategory("CategoryId")) %>">
                                            <% response.write(RSCategory("Category")) %></option>
                                        <%
                                        RSCategory.MoveNext
                                                Loop
                        
                                                RSCategory.Close
                                                Set RSCategory = Nothing
                                            %>
                                    </select>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">New Category</label>
                                    <input type="text" name="FormNewCategory" id="NewCategory" class="form-control"
                                        disabled>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Author Name</label>
                                    <br>
                                    <select name="FormAuthorId" class="form-control" id="SelectAuthor"
                                        onchange="ValidateOtherOption(this, document.getElementById('NewAuthor'));">
                                        <option value="-1">Select Author</option>
                                        <option value="-2">Others</option>
                                        <%
                                                Dim RSAuthor
                                                Set RSAuthor = Server.CreateObject("ADODB.RecordSet")
                                                
                                                RSAuthor.Open "SELECT * FROM ListAuthor ORDER BY AuthorName",Conn
            
                                                do while NOT RSAuthor.EOF
                                            %>
                                        <option value="<% response.write(RSAuthor("AuthorId")) %>">
                                            <% response.write(RSAuthor("AuthorName")) %></option>
                                        <%
                                        RSAuthor.MoveNext
                                                Loop
                        
                                                RSAuthor.Close
                                                Set RSAuthor = Nothing
                                            %>
                                    </select>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">New Author</label>
                                    <input type="text" name="FormNewAuthor" id="NewAuthor" class="form-control"
                                        disabled>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Publisher</label>
                                    <br>
                                    <select name="FormPublisherId" class="form-control" id="SelectPublisher"
                                        onchange="ValidateOtherOption(this, document.getElementById('NewPublisher'));">
                                        <option value="-1">Select Publisher</option>
                                        <option value="-2">Others</option>
                                        <%
                                                Dim RSPublisher
                                                Set RSPublisher = Server.CreateObject("ADODB.RecordSet")
                                                
                                                RSPublisher.Open "SELECT * FROM ListPublisher ORDER BY Publisher",Conn
            
                                                do while NOT RSPublisher.EOF
                                            %>
                                        <option value="<% response.write(RSPublisher("PublisherId")) %>">
                                            <% response.write(RSPublisher("Publisher")) %></option>
                                        <%
                                        RSPublisher.MoveNext
                                                Loop
                        
                                                RSPublisher.Close
                                                Set RSPublisher = Nothing
                                            %>
                                    </select> </div>
                            </div>
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">New Publisher</label>
                                    <input type="text" name="FormNewPublisher" id="NewPublisher" class="form-control"
                                        disabled>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">Language</label>
                                    <br>
                                    <select name="FormLanguageId" class="form-control" id="">
                                        <option value="-1">Select Language</option>
                                        <%
                                                Dim RSLanguage
                                                Set RSLanguage = Server.CreateObject("ADODB.RecordSet")
                                                
                                                RSLanguage.Open "SELECT * FROM ListLanguage",Conn
            
                                                do while NOT RSLanguage.EOF
                                            %>
                                        <option value="<% response.write(RSLanguage("LanguageId")) %>">
                                            <% response.write(RSLanguage("Language")) %></option>
                                        <%
                                        RSLanguage.MoveNext
                                                Loop
                        
                                                RSLanguage.Close
                                                Set RSLanguage = Nothing
                                            %>
                                    </select> </div>
                            </div>
                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">Book Pages</label>
                                    <input type="text" name="FormBookPages" id="" class="form-control">
                                </div>
                            </div>

                            <div class="col-4">
                                <div class="form-group">
                                    <label for="" class="input-heading">Quantity</label>
                                    <input type="text" name="FormQuantity" id="" class="form-control">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Cabinet No.</label>
                                    <br>
                                    <select name="FormCabinetId" class="form-control" id="">
                                        <option value="-1">Select Cabinet</option>
                                        <%
                                                Dim RSCabinet
                                                Set RSCabinet = Server.CreateObject("ADODB.RecordSet")
                                                
                                                RSCabinet.Open "SELECT * FROM ListCabinet",Conn
            
                                                do while NOT RSCabinet.EOF
                                            %>
                                        <option value="<% response.write(RSCabinet("CabinetId")) %>">
                                            <% response.write(RSCabinet("Cabinet")) %></option>
                                        <%
                                        RSCabinet.MoveNext
                                                Loop
                        
                                                RSCabinet.Close
                                                Set RSCabinet = Nothing
                                            %>
                                    </select> </div>
                            </div>

                            <div class="col-6">
                                <div class="form-group">
                                    <label for="" class="input-heading">Shelve No.</label>
                                    <br>
                                    <select name="FormShelveId" class="form-control" id="">
                                        <option value="-1">Select Shelve</option>
                                        <%
                                                Dim RSShelve
                                                Set RSShelve = Server.CreateObject("ADODB.RecordSet")
                                                
                                                RSShelve.Open "SELECT * FROM ListShelve",Conn
            
                                                do while NOT RSShelve.EOF
                                            %>
                                        <option value="<% response.write(RSShelve("ShelveId")) %>">
                                            <% response.write(RSShelve("Shelve")) %></option>
                                        <%
                                        RSShelve.MoveNext
                                                Loop
                        
                                                RSShelve.Close
                                                Set RSShelve = Nothing
                                            %>
                                    </select> </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg d-flex justify-content-center">
                                <input type="submit" value="Save" class="button">
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg d-flex justify-content-center text-center">
                                <span><% response.write(Session("Error")) %></span>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <br>
        </div>
    </div>

    <footer>
        <!--#include file=Footer.asp-->
    </footer>
</body>

<script>
    function ValidateOtherOption(Target, TargetElement) {
        var TargetValue = Target.value;
        if (TargetValue == -2) {
            TargetElement.removeAttribute('disabled');
        }
    }
</script>

</html>