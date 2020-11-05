import r from "koa-route";
import Koa from "koa";
import { posts, comments } from "./data.mjs";

const app = new Koa();

app.use(
  r.get("/posts", function (ctx) {
    ctx.body = {
      posts: posts,
    };
  })
);

app.use(
  r.get("/posts/:id/comments", function (ctx, id) {
    ctx.body = {
      comments: comments.filter((comment) => comment.postId === id),
    };
  })
);

app.use(async (ctx, next) => {
  ctx.res.setHeader("Content-Type", "application/json");
  if (typeof ctx.body === "object") {
    ctx.body = JSON.stringify(ctx.body);
  }
  console.log(ctx);
  next();
});

app.listen(3000);
