<%@ include file="jsp/header.jsp"%>
<div class="cotainer">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    User Registration
                </div>
                <div class="card-body">
                    <form method="POST" action="/moviebooking/register">

                        <input 
                            type="text" 
                            id="username" 
                            name="username" 
                            required 
                            class="w-full h-9 p-2.5 bg-zinc-800 text-black rounded-lg border border-zinc-500 focus:outline-none focus:ring-1 focus:ring-white"
                            >

                        <input 
                            type="password" 
                            id="password" 
                            name="password" 
                            required 
                            class="w-full h-9 p-2.5 bg-zinc-800 text-black rounded-lg border border-zinc-500 focus:outline-none focus:ring-1 focus:ring-white"
                            >

                        <button 
                            type="submit" 
                            class="w-56 p-3 bg-black text-sm text-white hover:bg-blue-500 h-11 rounded-3xl items-center focus:outline-none font-semibold"
                            >
                            Register Now
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="jsp/footer.jsp"%>

