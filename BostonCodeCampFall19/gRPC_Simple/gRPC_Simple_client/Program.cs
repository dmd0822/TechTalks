using Grpc.Core;
using Grpcdemo;
using System;

namespace gRPC_Simple_client
{
    class Program
    {
        static void Main(string[] args)
        {
            var num1 = 1; var num2 = 3;

            Channel channel = new Channel("127.0.0.1:50051", ChannelCredentials.Insecure);
            var addClient = new AddDemo.AddDemoClient(channel);

            Console.WriteLine($"Adding {num1.ToString()} and {num2.ToString()}");

            var addReply = addClient.AddNumber(new AddRequest { FirstNumber = num1, SecondNumber = num2 });
            Console.WriteLine($"Your total is {addReply.Total}");

            channel.ShutdownAsync().Wait();
            Console.WriteLine("Press any key to exit...");
            Console.ReadKey();
        }
    }
}
