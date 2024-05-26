with GNATCOLL.Sockets;
with GNATCOLL.JSON;
with GNATCOLL.HTTP;
with GNATCOLL.XML;
with GNATCOLL.HTTP.Server;

procedure Telegram_Bot is
   use GNATCOLL.Sockets;
   use GNATCOLL.JSON;
   use GNATCOLL.HTTP;

   Token : constant String := "YOUR_TELEGRAM_BOT_TOKEN";
   Google_API_Key : constant String := "YOUR_GOOGLE_API_KEY";
   Search_Engine_ID : constant String := "YOUR_SEARCH_ENGINE_ID";
   Bot_API_Url : constant String := "https://api.telegram.org/bot" & Token & "/";
   
   function Fetch_URL (URL : String) return String is
      Client : HTTP.Client := HTTP.Client;
      Request : HTTP.Request;
      Response : HTTP.Response;
   begin
      Request.Set_Method (HTTP.GET);
      Request.Set_URL (URL);
      Response := Client.Send_Request (Request);
      return Response.Get_Body;
   end Fetch_URL;

   function Search_Google (Query : String) return String is
      Search_URL : constant String := "https://www.googleapis.com/customsearch/v1?key=" & Google_API_Key & "&cx=" & Search_Engine_ID & "&q=" & Query;
   begin
      return Fetch_URL (Search_URL);
   end Search_Google;

   procedure Send_Message (Chat_ID : Integer; Text : String) is
      Send_URL : constant String := Bot_API_Url & "sendMessage?chat_id=" & Chat_ID'Img & "&text=" & Text;
   begin
      Fetch_URL (Send_URL);
   end Send_Message;

   procedure Handle_Update (Update : JSON.Object'Class) is
      Message     : constant JSON.Object'Class := Update.Get_Object ("message");
      Chat_ID     : constant Integer := Integer (Message.Get_Object ("chat").Get_Integer ("id"));
      Text        : constant String := Message.Get_String ("text");
      Search_Results : constant String := Search_Google (Text);
   begin
      Send_Message (Chat_ID, Search_Results);
   end Handle_Update;

   procedure Main is
      Offset : Integer := 0;
   begin
      loop
         declare
            Updates_URL : constant String := Bot_API_Url & "getUpdates?offset=" & Offset'Img;
            Updates : constant JSON.Value := JSON.Parse (Fetch_URL (Updates_URL));
            Updates_Array : constant JSON.Array_Access := Updates.Get_Array_Access;
         begin
            for Update of Updates_Array.Iterate loop
               Handle_Update (Update.Get_Object);
               Offset := Integer (Update.Get_Object.Get_Integer ("update_id")) + 1;
            end loop;
         end;
         delay 1.0;
      end loop;
   end Main;

begin
   Main;
end Telegram_Bot;
