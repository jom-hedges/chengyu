import app/web.{type Context}
import bytes_builder
import gleam/dict
import gleam/list
import gleam/dynamic.{type Dynamic}
import gleam/http.{Get, Post}
import gleam/json
import gleam/result.{try}
import mist
import sqlight
import wisp.{type Request, type Response}

// Request handler used for all requests to '/chengyu'
//
pub fn all(req: Request, ctx: Context) -> Response {
  // Dispatch to appropriate handler based on HTTP method
  case req.method {
    Get -> list_chengyu(ctx)
    Post -> create_chengyu(req, ctx)
    _ -> wisp.method_not_allowed([Get, Post])
  }
}

// This request handler is used for all requests to '/chengyu/:id'
// 
pub fn one(req: Request, ctx: Context, id: String) -> Response {
  // Dispatch to appropriate handler based on HTTP method 
  case req.method {
    Get -> read_chengyu(ctx, id)
    _ -> wisp.method_not_allowed([Get])
  }
}

pub type Chengyu {
  Chengyu(zh_text: String, en_text: String)
}

pub fn create_chengyu(req: Request, ctx: Context) {
  // Read the JSON from the request body
  use json <- wisp.require_json(req)

  let result = {
    // Decode the JSON into a Chengyu record
    use chengyu <- try(decode_chengyu(json))

    // Save the newly created chengyu to the database
    use id <- try(save_to_database(ctx.db, chengyu))

    // Construct a JSON payload with the ide of the newly created chengyu
    Ok(json.to_string_tree(json.object([#("id", json.string(id))])))
  }
}

pub fn plain_text_response(text: String) -> Response {
  // Placeholder: returns 404 Not Found for now
  wisp.not_found()
}

pub fn list_chengyu(ctx: Context) -> Response {
  let decoder = dynamic.tuple2(dynamic.string, dynamic.string)
  let query_sql = "select zh_def, en_def from chengyu;"
  // query the database
  case sqlight.query(query_sql, ctx.db, [], decoder) {
    Ok(rows) -> {
      // Convert the rows into a list of Chengyu
      let chengyu_list =
        rows
        |> list.map(fn(row) {
          case row {
            #(zh, en) -> Chengyu(zh_text: zh, en_text: en)
          }
        })
      // Convert the list of Chengyu to JSON
      let json_value = json.array(
        chengyu_list
        |> list.map(fn((Chengyu(zh_text, en_text))) {
          json.object([
            #("zh_text", json.string(zh_text)),
            #("en_text", json.string(en_text))
          ])
        })
      )
      let json = json.to_string(json_value)
      wisp.response(200, [], json, "application/json")
    }
    Error(_) -> wisp.internal_server_error()
  }
}

pub fn read_chengyu(ctx: Context, id: String) -> Response {
  plain_text_response("Not implemented")
}

fn decode_chengyu(_json: Dynamic) -> Result(Chengyu, Nil) {
  // TODO: implement decoding
  Error(Nil)
}

fn save_to_database(_db, _chengyu) -> Result(String, Nil) {
  // TODO: implement saving to database
  Error(Nil)
}
