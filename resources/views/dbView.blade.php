<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <a href="/add-note">
        <button type = "submit"> Add Note</button>
    </a>
    <h1>Data shown from MySQL database</h1>
    <table border= "1">
        <tr>
            <td>ID</td>
            <td>Title</td>
            <td>Description</td>
            <td>Time created</td>
            <td>Actions</td>
        </tr>
        @foreach($data as $item)
        <tr>
            <td>{{ $item['id'] }}</td>
            <td>{{ $item['title'] }}</td>
            <td>{{ $item['description'] }}</td>
            <td>{{ $item['created'] }}</td>
            <td> 
            <a href={{"update-note/".$item['id']}}>
                <button>Update Note</button>
                </a>
                <label for=""> / </label>
                <a href={{"delete-note/".$item['id']}}>
                <button>Delete Note</button>
                </a>
            </td>
        </tr>
        @endforeach
        
    </table>
</body>
</html>