import { inferAsyncReturnType, initTRPC } from '@trpc/server';
import { createHTTPServer } from '@trpc/server/adapters/standalone';
import cors from 'cors';
import { z } from 'zod';
export const t = initTRPC.create();
export const appRouter = t.router({
  getUser: t.procedure.input(z.string()).query((opts): { error: string } | {id: string, name: string } => {
    if (opts.input === 'oie') return { error: 'sim '}
    return { id: opts.input, name: 'Bilbo' };
  }),
  createUser: t.procedure
    .input(z.object({ name: z.string().min(5) }))
    .mutation(async (opts) => {
      // use your ORM of choice
      if (opts.input.name === 'bunda') return 'nao'
      return 'sim'
    }),
});
// export type definition of API
export type AppRouter = typeof appRouter;

createHTTPServer({
  router: appRouter,
  middleware: cors({ 
    origin: ["http://localhost:19000", "http://localhost:3001"],
    credentials: true,
    allowedHeaders: ['Content-Type', 'Authorization', 'x-csrf-token', 'sentry-trace'],
    maxAge: 600,
    exposedHeaders: ['*', 'Authorization']
  }), 
}).listen(5000);
