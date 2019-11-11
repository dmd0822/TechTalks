using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using Grpc.Core;
using Grpcdemo;

namespace gRPC_Simple_Server
{
    public class Calculator: AddDemo.AddDemoBase
    {
        public override Task<AddReply> AddNumber(AddRequest request, ServerCallContext context)
        {
            return Task.FromResult(new AddReply { Total = request.FirstNumber + request.SecondNumber });
        }
    }
}
