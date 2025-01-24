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
