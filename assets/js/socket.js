// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/web/endpoint.ex":
import {Socket} from "phoenix"
var endpoint = "/api/create";

var button = document.getElementById("create_button");
var inputs = document.getElementsByTagName("input");
var display = document.getElementById("spreadsheet_id_display");
var joinButton = document.getElementById("join_button");
var joinInput = document.getElementById("join_input");

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

// Now that you are connected, you can join channels with a topic:
let channel = null

// Initializes a channel with the server for the specific spreadsheet.
function createChannel(spreadsheetId) {
  channel = socket.channel("spreadsheet:" + spreadsheetId, {})
  channel.on("server_update", handle_server_update)
  channel.join()
    .receive("ok", resp => { console.log("Joined successfully", resp) })
    .receive("error", resp => { console.log("Unable to join", resp) })
}

// Handles the server update to adjust the client's ui.
function handle_server_update(message) {
  console.log(message.input_id)
  console.log(message.body)

  let input = document.getElementById(message.input_id)
  input.value = message.body
}

// Handler to hit the create endpoint and return the table's new id.
function createNewTable(event) {
  var spreadsheetId = ""

  fetch('/api/create')
    .then(function(response) {
      return response.json();
    })
    .then(function(json) {
      spreadsheetId = json.new_table_id;
      console.log(spreadsheetId);
      createChannel(spreadsheetId);
      display.innerHTML = spreadsheetId;
    });
}

// Blur on keyup
function keyup(event) {
  event.preventDefault();
  if (event.keyCode == 13) {
    event.target.blur();
  }
}

// On blur send the data to the client
function clientUpdate(event) {
  if (channel === null) {
    return;
  }

  // TODO: don't get the innerhtml, thats kinda shit
  channel.push("client_update", 
    {
      body: event.target.value,
      input_id: event.target.id,
      table_id: display.innerHTML
    });
}

// Join an existing spreadsheet, by id
function join(event) {
  var spreadsheetId = joinInput.value

  if (spreadsheetId === "") {
    return;
  }

  createChannel(spreadsheetId);
  display.innerHTML = spreadsheetId;
}

// Create a new table and make a socket connection.
button.addEventListener("click", createNewTable);

// Join an existing table
joinButton.addEventListener("click", join);

// Blur on enter up, on blur push client update.
for (var i = 0; i < inputs.length; i++) {
  inputs[i].addEventListener("keyup", keyup);
  inputs[i].addEventListener("blur", clientUpdate);
}

export default socket
