import app/web.{type Context}
import gleam/dict
import gleam/dynamic.{type Dynamic}
import gleam/http.{Get, Post}
import gleam/json
import gleam/result.{try}
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
pub fn one(req: Request, ctx: Context) -> Response {
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

pub fn list_chengyu() {
  // TODO: create list_chengyu function
}

pub read_chengyu() {
  // TODO: create read_chengyu function
}

fn decode_chengyu(json: Dynamic) -> Result(Chengyu, nil) {
  // TODO: create decode_chengyu function
}

fn save_to_database() {
  // TODO: create save_to_database function
}
