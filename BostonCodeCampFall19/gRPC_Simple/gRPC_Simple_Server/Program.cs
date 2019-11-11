using Grpc.Core;
using Grpcdemo;
using System;
using System.Threading;

namespace gRPC_Simple_Server
{
    class Program
    {
        private readonly static ManualResetEvent shutdown = new ManualResetEvent(false);      

        static void Main(string[] args)
        {
            int Port = 50051;
            Server server = new Server
            {
                Services = { AddDemo.BindService(new Calculator()) },
                Ports = { new ServerPort("0.0.0.0", Port, ServerCredentials.Insecure) }
            };
            server.Start();

            Console.WriteLine("AddDemo server listening on port " + Port);
            Console.Read();

            shutdown.WaitOne();
        }
    }
}
