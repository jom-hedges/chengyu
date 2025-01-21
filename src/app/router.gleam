import app/web.{type Context}
import gleam/dynamic.{type Dynamic}
import gleam/http.{Get, Post}
import gleam/json
import gleam/dict
import gleam/result.{try}
import sqlight
import wisp.{type Request, type Response}

// This request handler is used for requests to /chengyu
pub fn all(req: Request, ctx: Context) -> Response {
  // Dispatch to the appropriate handler based on the HTTP method
  case req.method {
    Get -> list_chengyu(ctx)
    Post -> create_chengyu(req, ctx)
    _ -> wisp.method_not_allowed([Get, Post])
  }
}

// This request handler used for requests to /chengyu/:id
pub fn one(req: Request, ctx: Context, id: String) -> Response {
  // Dispatch to the appropriate handler based on the HTTP method
  case req.method {
    Get -> read_chengyu(ctx, id)
    _ -> wisp.method_not_allowed([Get])
  }
}

pub type Chengyu {
  Chengyu(zh_def: String, en_def: String)
}

pub fn list_chengyu() {
  // todo
}

pub fn create_chengyu() {
  // todo
}

pub fn read_chengyu() {
  // todo
}

fn decode_chengyu(json: Dynamic) -> Result(Person, Nil) {
  // todo
}

// Save a person to the database and return the id of the newly created chengyu
pub fn save_to_database() {
  // todo
}

pub fn read_from_database(
  
)


